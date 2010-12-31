//
//  SpeakerDetailController.h
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SpeakerDetailController : UIViewController {
	NSDictionary *speakerDictionary;
	UIWebView *webView;
}

@property (readwrite, retain, nonatomic) NSDictionary *speakerDictionary;
@property (readonly, retain, nonatomic) IBOutlet UIWebView *webView;

@end
