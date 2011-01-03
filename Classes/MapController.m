//
//  MapController.m
//  TEDxPSU
//
//  Created by Nyceane on 9/18/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapController.h"

#define kVenueName @"Temple Nightclub"
#define kVenueAddress @"540 Howard Street, San Francisco, California"
#define kVenueLatitude 37.787835
#define kVenueLongitude -122.397067

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

-(IBAction)btnDirection_Clicked
{
	NSString *Address = [NSString stringWithFormat:kVenueAddress];
	NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@",
					 [Address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];	
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	CLLocationCoordinate2D location1;
	location1.latitude = kVenueLatitude;
	location1.longitude = kVenueLongitude;
	
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
	location1Annotation.mTitle = kVenueName;
	location1Annotation.mSubTitle = kVenueAddress;

	//Adds all 3 points
	[mapView addAnnotation:location1Annotation];
	mapView.zoomEnabled = FALSE;
	
	[location1Annotation release];
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
