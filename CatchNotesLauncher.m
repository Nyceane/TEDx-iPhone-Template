/*Copyright 2011 Catch.com
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.*/
//
//  CatchNotesLauncher.m
//
//  Created by Jeff Meininger on 8/2/10.  Modified By Peter Ma
//  Copyright 2011 Catch.com, Inc. All rights reserved.
//

#import "CatchNotesLauncher.h"

NSString *aboutHTML = @"<html>"
"<head>"
"<style type=\"text/css\">"
""
"* { margin:0; padding:0; }"
"p { margin:5px 0 10px 0; }"
""
"html, body {"
"	height: 100%;"
"	font-family: \"HelveticaNeue-Light\", \"Helvetica Neue Light\", \"Helvetica Neue\", sans-serif;"
"	color: gray;"
"	text-shadow: white 1px 1px 1px;"
"	background-color: whitesmoke;"
"}"
""
"#header {"
"	background-color: rgb(10, 31, 46);"
"	-webkit-box-shadow: rgb(148, 148, 148) 0px 0px 8px;"
"	background-color: rgb(10, 31, 46);"
"	border-bottom: 2px solid rgb(24, 77, 112);"
"	-webkit-gradient(linear, 0% 0%, 0% 100%, from(#11364F), to(#0A1F2E), color-stop(0,#11364F));"
"	position: fixed;"
"	top: 0;"
"	left: 0;"
"	width: 100%;"
"	-webkit-box-shadow: rgb(68, 68, 68) 0px 0px 8px;"
"	text-shadow: none;"
"	padding: 10px 0px;"
"	height: 31px;"
"	z-index: 1;"
"}"
""
"#header .logo {"
"	margin-left: 5px;"
"	float: left;"
"	border: none;"
"	height: 31px;"
"}"
""
"#main {"
"	padding-top: 65px;"
"	width:90%;"
"	margin-left:auto;"
"	margin-right:auto;"
"}"
""
".form-title {"
"	padding-left: 10px;"
"}"
""
"div.box {"
"	-webkit-border-bottom-left-radius: 5px 5px;"
"	-webkit-border-bottom-right-radius: 5px 5px;"
"	-webkit-border-top-left-radius: 5px 5px;"
"	-webkit-border-top-right-radius: 5px 5px;"
"	-webkit-box-shadow: rgba(0, 0, 0, 0.160156) 0px 2px 5px;"
"	background-color: white;"
"	margin: 8px auto auto;"
"	margin-left: auto;"
"	margin-right: auto;"
"	padding: 20px;"
"}"
""
"div.box .label {"
"	font-size: 1em;"
"	font-weight: bold;"
"}"
""
"div.box div {"
"	margin-bottom:12px;"
"}"
"div.box div.label {"
"	margin-bottom:3px;"
"}"
""
"button {"
"	border: 0;"
"	border-bottom: 1px solid rgba(0,0,0,0.25);"
"	border-bottom: 1px solid #222;"
"	outline: 0;"
"	margin: 0;"
"	margin-top: 5px;"
"	padding: 9px 10px 10px;"
"	display: inline-block;"
"	padding: 8px 14px 9px;"
"	color: #fff;"
"	background-color:#909090;"
"	text-decoration: none;"
"	font-size: 1.1em;"
"	font-weight: bold;"
"	text-shadow: 0 -1px 1px #222;"
"	line-height: 1;"
"	-moz-border-radius: 5px;"
"	-webkit-border-radius: 5px;"
"	-moz-box-shadow: 0 1px 3px #999;"
"	-webkit-box-shadow: 0 1px 3px #999;"
"	position: relative;"
"	cursor: pointer;"
"	-moz-box-shadow: 0 1px 3px rgba(0,0,0,0.5);"
"	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.5);"
"	text-shadow: 0 -1px 1px rgba(0,0,0,0.25);"
"}"
""
"button.appStore {"
"	background-color: #91bd09;"
"}"
""
"</style>"
"</head>"
""
"<body>"
""
"<div id=\"header\"> "
"<div class=\"logo\"> "
"</div> "
"<div class=\"logo\"> "
"<img class=\"logo\" src=\"data:image/png;base64,"
"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"
"\" />"
"</div>"
"</div><!-- header -->"
"	<div id=\"main\"> "
"		<h2>Capture what matters</h2>"
"		<div class=\"box\">"
"			<div class=\"label\">Save all your snippets</div>"
"			<div>Notes, images, ideas, to-dos, numbers, names, links, locations, recipes, articles - in one place.</div>"
"			"
"			<div class=\"label\">With you wherever you go</div>"
"			<div>Free syncing with Android, iPhone, and iPad, lets you keep your important notes by your side.</div>"
"		</div>"
"		<br />"
"		<center><button class=\"appStore\" onclick=\"window.location='itms-apps://itunes.apple.com/us/app/3banana-notes/id355424047?mt=8'\">Get Catch Notes - It's Free!</button><br />"
"		<button class=\"cancel\" onclick=\"window.location='cocoa://cancel/'\">No, Thanks</button></center>"
"	</div><!-- main -->"
""
"</body>"
"</html>";


@implementation CatchNotesLauncher


+ (void)openURL:(NSURL*)url fromViewController:(UIViewController*)viewController
{
	if ([[UIApplication sharedApplication] canOpenURL:url]) {
		[[UIApplication sharedApplication] openURL:url];
	} else {
		NSAssert([viewController isKindOfClass:[UIViewController class]], 
			@"The viewController parameter must be a valid UIViewController.");
		
		CatchNotesLauncher *aboutCatcnNotes = [[CatchNotesLauncher alloc] init];
		[viewController presentModalViewController:aboutCatcnNotes animated:YES];
		[aboutCatcnNotes release];
	}
}


+ (void)createNewNoteWithText:(NSString*)text cursorAt:(NSInteger)offset 
	bounceOnSave:(NSString*)saveUri bounceOnCancel:(NSString*)cancelUri 
	fromViewController:(UIViewController*)viewController
{
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:
		@"catch://notes/new?text=%@&cursor_at=%i&bounce_on_save=%@&bounce_on_cancel=%@", 
		[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], 
		offset, 
		[saveUri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], 
		[cancelUri stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	[self openURL:url fromViewController:viewController];
}


+ (void)createNewNoteWithText:(NSString*)text 
	fromViewController:(UIViewController*)viewController
{
	NSURL *url = [NSURL URLWithString:[NSString 
		stringWithFormat:@"catch://notes/new?text=%@", 
		[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	[self openURL:url fromViewController:viewController];
}


+ (void)showNotesMatchingText:(NSString*)text 
	fromViewController:(UIViewController*)viewController
{
	NSURL *url = [NSURL URLWithString:[NSString 
		stringWithFormat:@"catch://notes/search?text=%@", 
		[text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	[self openURL:url fromViewController:viewController];
}


+ (void)showNotesWithTag:(NSString*)tag 
	fromViewController:(UIViewController*)viewController
{
	NSURL *url = [NSURL URLWithString:[NSString 
		stringWithFormat:@"catch://notes/tag?name=%@", 
		[tag stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
	[self openURL:url fromViewController:viewController];
}



- (void)loadView
{	
	UIWebView *webView = [[UIWebView alloc] init];
	webView.delegate = self;
	self.view = webView;
	[webView release];
	
	[webView loadHTMLString:aboutHTML baseURL:nil];
}


- (void)dealloc
{
    [super dealloc];
}



- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request 
	navigationType:(UIWebViewNavigationType)navigationType
{
	NSURL *url = [request URL];
	if ([[url absoluteString] isEqualToString:@"cocoa://cancel/"]) {
		[self.parentViewController dismissModalViewControllerAnimated:YES];
		return NO;
	} else if ([[url scheme] isEqualToString:@"itms-apps"]) {
		[[UIApplication sharedApplication] openURL:url];
		return NO;
	}
	
	return YES;
}



@end

