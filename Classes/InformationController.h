//
//  InformationController.h
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewControllerBaseClass.h"

@interface InformationController : WebViewControllerBaseClass {
	UIBarButtonItem *btnContact;
}

@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnContact;

-(IBAction)btnEmail_Clicked;

@end
