    //
//  WebViewControllerBaseClass.m
//  TEDxAlcatraz
//
//  Created by Michael May on 03/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WebViewControllerBaseClass.h"
#import "TEDxAlcatrazGlobal.h"

@interface WebViewControllerBaseClass (InternalMethods) 
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@end


@implementation WebViewControllerBaseClass

@synthesize webView;

#pragma mark -

- (void)webViewDidStartLoad:(UIWebView *)webView {
	DLog(@"webViewDidStartLoad");
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	DLog(@"webViewDidFinishLoad");
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)loadURLString:(NSString*)URLString {
	NSURL *url = [NSURL URLWithString:URLString];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	[webView loadRequest:requestObj];
}

#pragma mark -

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	
	self.webView = nil;
}

- (void)dealloc {
	[webView release];
	
    [super dealloc];
}

@end
