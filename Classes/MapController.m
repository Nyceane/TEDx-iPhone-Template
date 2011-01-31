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
//  MapController.m
//  TEDxPSU
//
//  Created by Nyceane on 9/18/10. Updated by Michael May.
//  Copyright 2010 Peter Ma. All rights reserved.
//

#import "MapController.h"
#import "TEDxAlcatrazGlobal.h"

//#define kVenueName @"Temple Nightclub"
//#define kVenueAddress @"540 Howard Street, San Francisco, California"
//#define kVenueLatitude 37.787835
//#define kVenueLongitude -122.397067

#pragma mark -
#pragma mark AddressAnnotation

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
}

@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mSubTitle;

@end


@implementation AddressAnnotation

@synthesize coordinate, mTitle, mSubTitle;

- (NSString *)subtitle{
	return mSubTitle;
}
- (NSString *)title{
	return mTitle;
}

-(id)initWithCoordinate:(CLLocationCoordinate2D)c {
	self = [super init];
	
	if(self) {
		coordinate=c;
	}
	
	return self;
}

-(void)dealloc {
	[mTitle release];
	[mSubTitle release];
	
	[super dealloc];
}

@end

#pragma mark -
#pragma mark MapController

@interface MapController (InternalMethods) 
@property (retain, nonatomic) IBOutlet MKMapView*  mapView;
@end

@implementation MapController

@synthesize mapView;

#pragma mark -
#pragma mark Venue Details Dictionary from Main Bundle

// &ll=51.535165,-0.122223

#pragma mark -

-(IBAction)btnDirection_Clicked
{
	NSDictionary *TEDxVenueDetails = [TEDxAlcatrazGlobal venueDictionary];
	NSString *Address = [TEDxVenueDetails objectForKey:@"Address"]; //[NSString stringWithFormat:kVenueAddress];
	NSNumber *venueLatitude = [TEDxVenueDetails objectForKey:@"Latitude"];
	NSNumber *venueLongitude = [TEDxVenueDetails objectForKey:@"Longitude"];
	NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&ll=%f,%f",
					 [Address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],
					 [venueLatitude doubleValue],
					 [venueLongitude doubleValue]];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];	
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSDictionary *TEDxVenueDetails = [TEDxAlcatrazGlobal venueDictionary];
	
	CLLocationCoordinate2D location1;
	{
		NSNumber *venueLatitude = [TEDxVenueDetails objectForKey:@"Latitude"];
		NSNumber *venueLongitude = [TEDxVenueDetails objectForKey:@"Longitude"];
		location1.latitude = [venueLatitude doubleValue];//kVenueLatitude;
		location1.longitude = [venueLongitude doubleValue];//kVenueLongitude;
	}
	
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
	location1Annotation.mTitle = [TEDxVenueDetails objectForKey:@"Name"]; //kVenueName;
	location1Annotation.mSubTitle = [TEDxVenueDetails objectForKey:@"Address"]; //kVenueAddress;

	//Adds all 3 points
	[mapView addAnnotation:location1Annotation];
	mapView.zoomEnabled = FALSE;
	
	[location1Annotation release];
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.mapView = nil;
}

- (void)dealloc {
	[mapView release];
	
    [super dealloc];
}


@end
