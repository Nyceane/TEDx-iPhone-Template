//
//  MapController.m
//  TEDxPSU
//
//  Created by Nyceane on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"

@implementation AddressAnnotation

@synthesize coordinate, mTitle, mSubTitle;

- (NSString *)subtitle{
	return mSubTitle;
}
- (NSString *)title{
	return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

@end

@implementation MapController
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CLLocationCoordinate2D location1;
	location1.latitude = 37.787835;
	location1.longitude = -122.397067;
	
	mapView.centerCoordinate = location1;

	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.01;
	span.longitudeDelta=0.01;
	
	region.span=span;
	region.center=location1;
	
	[mapView setRegion:region animated:FALSE];
	[mapView regionThatFits:region];

	AddressAnnotation *location1Annotation = [[AddressAnnotation alloc] initWithCoordinate:location1];
	location1Annotation.mTitle = @"Temple Nightclub";
	location1Annotation.mSubTitle = @"540 Howard Street, San Francisco, California";

	//Adds all 3 points
	[mapView addAnnotation: location1Annotation];
	mapView.zoomEnabled = FALSE;
}

-(IBAction)btnDirection_Clicked
{
	NSString *Address = [NSString stringWithFormat: @"540 Howard Street, San Francisco, California"];
	NSString *url = [NSString stringWithFormat: @"http://maps.google.com/maps?q=%@",
					 [Address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
