/*
 The MIT License
 
 Copyright (c) 2010 Peter Ma
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
//
//  SpeakersResultController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10. Updated by Michael May.
//  Copyright 2010 Peter Ma. All rights reserved.
//

#import "TEDxAlcatrazAppDelegate.h"

#import "SpeakersResultController.h"
#import "SpeakersResultTableViewCell.h"
#import "SpeakerDetailController.h"
#import "JSON.h"

#define kEventId	13
#define kPages		1

@implementation SpeakersResultController

#pragma mark -

#define kImageFileNameFormat @"%d.dat"
#define kImageCacheDirectoryName @"imagecache"

-(void)createTempPath {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:kImageCacheDirectoryName]];
	
	if([[NSFileManager defaultManager] fileExistsAtPath:tempPath] == NO) {
		NSError *error;
		BOOL createdDir = [[NSFileManager defaultManager] createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:&error];
		
		NSLog(@"Created Directory: %@ (Success:%d)", tempPath, createdDir);
	}
}

-(NSString*)tempPathForSpeakerImage:(NSDictionary*)speaker {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *tempPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:kImageCacheDirectoryName]];
	
	tempPath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:kImageFileNameFormat, [TEDxAlcatrazGlobal speakerIdFromJSONData:speaker]]];
	
	return tempPath;
}

-(UIImage*)imageForSpeaker:(NSDictionary*)speaker {
	NSString* path = [self tempPathForSpeakerImage:speaker];
	UIImage *image = nil;
	
	if([[NSFileManager defaultManager] fileExistsAtPath:path] == YES) {		
		image = [[UIImage alloc] initWithContentsOfFile:path];
		
		DLog(@"Found image for speaker:Path:%@ (Image:%@)", path, image);
	}
	
	return image;
}

-(void)setImage:(UIImage*)image forSpeaker:(NSDictionary*)speaker {
	NSString* path = [self tempPathForSpeakerImage:speaker];

	BOOL success = [[NSFileManager defaultManager] createFileAtPath:path 
															contents:UIImagePNGRepresentation(image)
														  attributes:nil];
	
	DLog(@"Set Image:Path:%@ Success:%d", path, success);
}

#pragma mark -
#pragma mark getting data

-(void)getSpeakersInBackground {	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *requestString = [NSString stringWithFormat:
							   @"http://www.tedxapps.com/wsdl/TEDxService.svc/GetSpeakersByEventId?eventid=%i&page=%i",
							   [TEDxAlcatrazGlobal eventIdentifier],
							   kPages];
	
	NSURLRequest *newUserURLRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:requestString]];
	
	//Data returned by Web Service
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:newUserURLRequest returningResponse:nil error:nil];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	DLog(@"Speakers:%@", returnString);
	
	[speakers release];
	speakers = [[returnString JSONValue] retain];
	
	[[self tableView] performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
	
	[returnString release];
	
	[pool drain];
}

// this is a stop-gap solution as we really need to be caching these images, not downloading them each time
-(void)getImageInBackgroundForIndexPath:(NSIndexPath*)indexPath {
	if(speakers) {
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		NSDictionary *speaker = [speakers objectAtIndex:[indexPath row]];
		
		[self createTempPath];
		
		UIImage* image = [[self imageForSpeaker:speaker] retain];
		
		if(image == nil) {
			DLog(@"Getting data for %@ (speaker:%d)", indexPath, [TEDxAlcatrazGlobal speakerIdFromJSONData:speaker]);		
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];		
			
			NSData *receivedData =  [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[TEDxAlcatrazGlobal photoURLFromJSONData:speaker]]];
			
			[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
			
			image = [[UIImage alloc] initWithData:receivedData];
			
			[receivedData release];
			
			[self setImage:image forSpeaker:speaker];
		}
		
		UITableViewCell *cell = nil;
		@try {
			cell = [[self tableView] cellForRowAtIndexPath:indexPath];
		}
		@catch (NSException * e) {
			cell = nil;
		}
		
		if(cell) {
			DLog(@"Setting Image (%@) for Cell with IndexPath:%@", [cell imageView], indexPath);
			
			[[cell imageView] performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
			[[cell imageView] setFrame:CGRectMake(0, 0, 70, 70)];
			[cell setNeedsLayout];
			
			DLog(@"Set image:%@", [cell imageView]);
		}
		
		[image release];
				
		[pool drain];
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [speakers count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TEDxSpeakerCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[SpeakersResultTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// Configure the cell...
	NSDictionary *speaker = [speakers objectAtIndex:[indexPath row]];
	
	UIImage* image = [[self imageForSpeaker:speaker] retain];
	cell.imageView.image = image;	
	
	cell.textLabel.text = [TEDxAlcatrazGlobal nameStringFromJSONData:speaker];		// speakers name
	cell.detailTextLabel.text = [TEDxAlcatrazGlobal titleFromJSONData:speaker];		// speakers profession
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	if(image == nil) {
		[self performSelectorInBackground:@selector(getImageInBackgroundForIndexPath:) withObject:indexPath];
	}
	
    return cell;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.title = @"Speakers";
	
	self.tableView.rowHeight = kSpeakersTableRowHeight;
	
	[self performSelectorInBackground:@selector(getSpeakersInBackground) withObject:nil];
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSDictionary *speaker = [speakers objectAtIndex:[indexPath row]];
	
	if(speaker) {
		SpeakerDetailController *speakerDetailController = [[SpeakerDetailController alloc] initWithSpeaker:speaker];
		[self.navigationController pushViewController:speakerDetailController animated:YES];
		[speakerDetailController release];
	}
	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	
	[speakers release], speakers = nil;
}


- (void)dealloc {
	[speakers release];
	
    [super dealloc];
}


@end

