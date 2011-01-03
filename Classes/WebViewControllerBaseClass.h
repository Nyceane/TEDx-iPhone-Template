//
//  WebViewControllerBaseClass.h
//  TEDxAlcatraz
//
//	A base class for all of the Web Views that are used in this app, reducing the amount of duplicated 
//	code throughout the App.
//
//  Created by Michael May on 03/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewControllerBaseClass :  UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
}

@property (readonly, nonatomic, retain) IBOutlet UIWebView *webView;

- (void)loadURLString:(NSString*)URLString;

@end
