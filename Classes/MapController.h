//
//  MapController.h
//  TEDxPSU
//
//  Created by Nyceane on 9/18/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapController : UIViewController <MKMapViewDelegate> {	
	MKMapView *mapView;
}

@property (readonly, retain, nonatomic) IBOutlet MKMapView*  mapView;

-(IBAction)btnDirection_Clicked;

@end
