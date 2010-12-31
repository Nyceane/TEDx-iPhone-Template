//
//  SpeakersResultController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TEDxAlcatrazAppDelegate.h"

#import "SpeakersResultController.h"
#import "SpeakerDetailController.h"
#import "JSON.h"

#define kEventId	13
#define kPages		1

@implementation SpeakersResultController

#pragma mark -

#define kImageFileNameFormat @"%@.dat"

-(void)createTempPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"imagecache"]];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:tempPath] == NO) {
		NSError *error;
		BOOL createdDir = [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:&error];
		
		NSLog(@"Created Directory: %@ (Success:%d)", tempPath, createdDir);
	}
}

-(NSString*)tempPathForIndexPath:(NSIndexPath*)indexPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"imagecache"]];
	
	tempPath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:kImageFileNameFormat, [indexPath section], [indexPath row]]];
	
	return tempPath;
}

#pragma mark -
#pragma mark getting data

/*
- (NSArray *)getSpeakers:(NSUInteger)page 
			 eventId:(NSUInteger)EventId
{	
	NSString *requestString = [NSString stringWithFormat:
							   @"http://www.paschar.com/wsdl/TEDxService.svc/GetSpeakersByEventId?eventid=%i&page=%i",
							   EventId,
							   page];
	//NSLog(@"%@", requestString);
	
	NSURLRequest *newUserURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	
	//Data returned by Web Service
	NSData *returnData = [NSURLConnection sendSynchronousRequest:newUserURLRequest returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSArray *responseArray = [returnString JSONValue];
	
	return responseArray;
}
*/

-(void)getSpeakersInBackground {	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *requestString = [NSString stringWithFormat:
							   @"http://www.paschar.com/wsdl/TEDxService.svc/GetSpeakersByEventId?eventid=%i&page=%i",
							   kEventId,
							   kPages];
	
	//NSLog(@"%@", requestString);
	
	NSURLRequest *newUserURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	
	//Data returned by Web Service
	NSData *returnData = [NSURLConnection sendSynchronousRequest:newUserURLRequest returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	[speakers release];
	speakers = [[returnString JSONValue] retain];
	
	[[self tableView] performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
	
	[pool drain];
}

// this is a stop-gap solution as we really need to be caching these images, not downloading them each time
-(void)getImageInBackgroundForIndexPath:(NSIndexPath*)indexPath {
	if(speakers) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		NSDictionary *speaker = [speakers objectAtIndex:[indexPath row]];
		
		DLog(@"Getting data for %@", indexPath);		
		
		NSData *receivedData =  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[speaker objectForKey:@"PhotoURL"]]];
				
		UITableViewCell *cell = [[self tableView] cellForRowAtIndexPath:indexPath];
		
		if(cell) {
			DLog(@"Setting Image (%@) for IndexPath:%@", [cell imageView], indexPath);
			
			UIImage *image = [[UIImage alloc] initWithData:receivedData];

			[[cell imageView] performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
			
			[cell setNeedsLayout];
			
			DLog(@"Set image:%@", [cell imageView]);
			
			[image release];
		}
		
		[receivedData release];
		
		[pool drain];
	}
}

#pragma mark -

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	//NSLog(@"%@", [[speakers objectAtIndex:section] objectForKey:@"speakers"]);
    return [speakers count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Configure the cell...
	NSDictionary *speaker = [speakers objectAtIndex:[indexPath row]];
	
	//int gameTypeId = [[game objectForKey:@"GameTypeId"] intValue];
	
	cell.imageView.image = nil;	
	
	[self performSelectorInBackground:@selector(getImageInBackgroundForIndexPath:) withObject:indexPath];
	
	/*
	//Get Game Image
	NSData *receivedData =  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[speaker objectForKey:@"PhotoURL"]]];
	
	cell.imageView.image = [[UIImage alloc] initWithData:receivedData];
	*/
	cell.imageView.image = nil;
	
	
	//get the speaker name
	NSString *Name = [NSString stringWithFormat:
						@"%@ %@",
						[speaker objectForKey:@"FirstName"],
						[speaker objectForKey:@"LastName"]];
	cell.textLabel.text = Name;
	
	//SubTitle
	cell.detailTextLabel.text = [speaker objectForKey:@"Title"];
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    	
    return cell;
}



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	//newGameButton = [[UIBarButtonItem alloc] initWithTitle:@"New Game" style:UIBarButtonItemStylePlain target:self action:nil];
	//myGameButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:nil];
	
	//self.navigationItem.leftBarButtonItem = myGameButton;
	//self.navigationItem.rightBarButtonItem = newGameButton;
	//tabBarController = self.tabBarController;
	
	self.navigationItem.title = @"Speakers";
	
	//speakers = [[self getSpeakers:1 eventId:13] retain];
	
	[self performSelectorInBackground:@selector(getSpeakersInBackground) withObject:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	NSDictionary *speaker = [speakers objectAtIndex:[indexPath indexAtPosition:1]];
	
	SpeakerDetailController *speakerDetailController = [[SpeakerDetailController alloc] initWithNibName:@"SpeakerDetailController" bundle:nil];
	speakerDetailController.speakerDictionary = speaker;
	
	[self.navigationController pushViewController:speakerDetailController animated:YES];
	[speakerDetailController release];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

