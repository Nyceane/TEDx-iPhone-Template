//
//  MapController.h
//  TEDxPSU
//
//  Created by Nyceane on 9/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
}

@property (nonatomic, retain) NSString *mTitle;
@property (nonatomic, retain) NSString *mSubTitle;


@end

@interface MapController : UIViewController <MKMapViewDelegate> {
	
	IBOutlet MKMapView *mapView;
}

-(IBAction)btnDirection_Clicked;

@end
