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
//  WebViewControllerBaseClass.m
//  TEDxAlcatraz
//
//  Created by Michael May on 03/01/2011.
//  Copyright 2011 Michael May. All rights reserved.
//

#import "WebViewControllerBaseClass.h"
#import "TEDxAlcatrazGlobal.h"

@interface WebViewControllerBaseClass (InternalMethods) 
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@end


@implementation WebViewControllerBaseClass

@synthesize webView;

#pragma mark -

#define kColouredBackgroundHTML @"<html><head></head><body style=\"background-color:transparent\">&nbsp;</body></html>"

// call this at viewDidAppear time, before loading aything else to 
// ensure the view starts with a defined colored background
-(void)setColouredBackgroundForWebView:(UIColor*)aColor {
	webView.backgroundColor = aColor;
	webView.opaque = NO;	
	
	[webView loadHTMLString:kColouredBackgroundHTML baseURL:nil];
}

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
