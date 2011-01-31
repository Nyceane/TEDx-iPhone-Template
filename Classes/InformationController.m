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
//  InformationController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10. Updated by Michael May.
//  Copyright 2010 Peter Ma. All rights reserved.
//

#import "InformationController.h"
#import "TEDxAlcatrazGlobal.h"

#define kTEDxInformationURL @"http://www.tedxapps.com/mobile/about/?EventId=%d"
#define kTEDxMailToSubject @"iPhone TEDx Question"
#define kTEDxMailToBody @"Dear TEDx Organiser"
#define kTEDxMailToURL @"mailto:%@?subject=iPhone TEDx Question&body=Dear TEDx Organiser"

@implementation InformationController

@synthesize btnContact;

#pragma mark -

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate Delegate callbacks

- (void)actionMailTo:(NSString*)to subject:(NSString*)subject body:(NSString*)body  {
	if([MFMailComposeViewController canSendMail]) {		
		MFMailComposeViewController* mcvc = [[MFMailComposeViewController alloc] init];
		
		[mcvc setToRecipients:[NSArray arrayWithObject:to]];
		[mcvc setSubject:subject];
		[mcvc setMessageBody:body isHTML:NO];
		[mcvc setMailComposeDelegate:self];

		[self presentModalViewController:mcvc animated:YES];
	} else {
		NSString *mailTo = [NSString stringWithFormat:kTEDxMailToURL, [TEDxAlcatrazGlobal emailAddress]];
		NSString *mailToEncoded = [mailTo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailToEncoded]];
	}
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
	
	if(error != nil && error.code != NSUserCancelledError) {
		UIAlertView *mailFailureAlert = [[UIAlertView alloc] initWithTitle:@"Cannot Send Email"
																   message:[error localizedDescription]
																  delegate:nil
														 cancelButtonTitle:@"OK" 
														 otherButtonTitles:nil];
		
		[mailFailureAlert show];
		
		[mailFailureAlert release];
	}
	
	[controller release];
}

#pragma mark -

-(IBAction)btnEmail_Clicked {
	[self actionMailTo:[TEDxAlcatrazGlobal emailAddress] subject:kTEDxMailToSubject body:kTEDxMailToBody];
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -

-(void)viewDidLoad {
	[super viewDidLoad];
	
	[super setColouredBackgroundForWebView:[UIColor blackColor]];
	
	[super loadURLString:[NSString stringWithFormat:kTEDxInformationURL, [TEDxAlcatrazGlobal eventIdentifier]]];
}

#pragma mark -

- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.btnContact = nil;
}

- (void)dealloc {
	[btnContact release];
	
    [super dealloc];
}

@end
