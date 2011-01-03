//
//  SpeakerViewController.h
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpeakerViewController : UIViewController <UINavigationControllerDelegate> {
	UINavigationController *navigationController;
}

@property (readonly, retain, nonatomic) IBOutlet UINavigationController* navigationController;

@end
