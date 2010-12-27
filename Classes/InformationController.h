//
//  InformationController.h
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InformationController : UIViewController {
	UIWebView *webView;
	UIBarButtonItem *btnContact;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *btnContact;

-(IBAction)btnEmail_Clicked;

@end
