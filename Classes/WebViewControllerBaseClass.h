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
//  WebViewControllerBaseClass.h
//  TEDxAlcatraz
//
//	A base class for all of the Web Views that are used in this app, reducing the amount of duplicated 
//	code throughout the App.
//
//  Created by Michael May on 03/01/2011.
//  Copyright 2011 Michael May. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewControllerBaseClass :  UIViewController <UIWebViewDelegate> {
	UIWebView *webView;
}

@property (readonly, nonatomic, retain) IBOutlet UIWebView *webView;

-(void)setColouredBackgroundForWebView:(UIColor*)aColor;

- (void)loadURLString:(NSString*)URLString;

@end
