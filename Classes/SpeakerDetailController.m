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
//  SpeakerDetailController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10. Updated by Michael May.
//  Copyright 2010 Peter Ma. All rights reserved.
//

#import "TEDxAlcatrazAppDelegate.h"
#import "SpeakerDetailController.h"
#import "TEDxAlcatrazGlobal.h"
#import "CatchNotesLauncher.h"

@implementation SpeakerDetailController
@synthesize actionControls, speakerToolBar;
#pragma mark -

-(id)initWithSpeaker:(NSDictionary*)speakerJSONDictionary {
	self = [super initWithNibName:@"SpeakerDetailController" bundle:nil];
	
	if(self) {
		speakerDictionary = [speakerJSONDictionary retain];
	}
	
	return self;
}

#pragma mark -
- (void)displayTabBar:(BOOL)hide
{
	UIView *view = ((TEDxAlcatrazAppDelegate*)[UIApplication sharedApplication].delegate).tabBarController.view;
	UITabBar * tabbar = ((TEDxAlcatrazAppDelegate*)[UIApplication sharedApplication].delegate).tabBarController.tabBar;
	CGRect viewFrame = view.frame;

	if(hide)
	{
		tabbar.alpha = 0.0;
		viewFrame.size.height += 40;
		viewFrame.origin.y += 20;

		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.75];
	
		view.frame = viewFrame;
		[UIView commitAnimations];
	}
	else {
		tabbar.alpha = 1.0;
		viewFrame.size.height -= 40;
		viewFrame.origin.y -= 20;
		
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
		
		view.frame = viewFrame;
		[UIView commitAnimations];
	}
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//Hide Tabbar
	[self displayTabBar:YES];
	
	self.navigationItem.title = [TEDxAlcatrazGlobal nameStringFromJSONData:speakerDictionary];

	//Set up WebView, just temporary to improve development speed
	NSString *urlAddress =	[NSString stringWithFormat:
							@"http://www.tedxapps.com/mobile/speaker/?SpeakerId=%d",
							[TEDxAlcatrazGlobal speakerIdFromJSONData:speakerDictionary]];

	[super loadURLString:urlAddress];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
	UIView *view = ((TEDxAlcatrazAppDelegate*)[UIApplication sharedApplication].delegate).tabBarController.view;
	CGRect viewFrame = view.frame;
	viewFrame.size.height += 30;
	view.frame = viewFrame;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

- (void)createCatchNoteWithText:(NSString*)text
{
	[CatchNotesLauncher createNewNoteWithText:text cursorAt:0 
							  bounceOnSave:@"catchted://catch-return/saved" 
							bounceOnCancel:@"catchted://catch-return/cancelled" 
						fromViewController:self];
}


- (void)addTextNote{
	NSMutableString *notes = [NSMutableString string];
	[notes appendString: [TEDxAlcatrazGlobal nameStringFromJSONData:speakerDictionary]];	
	[notes appendString: @"\nTitle:"];
	[notes appendString: [TEDxAlcatrazGlobal titleFromJSONData:speakerDictionary]];	
	[notes appendString: @"\nBio:"];
	[notes appendString: [TEDxAlcatrazGlobal DescriptionFromJSONData:speakerDictionary]];
	
	[notes appendString: @"\n\n"];
	[notes appendString: CONFERENCE_TAG];
	[notes appendString: @" #"];

	//Now Getting Speaker Name
	NSString *speakername = [[TEDxAlcatrazGlobal nameStringFromJSONData:speakerDictionary] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
	[notes appendString: speakername];
	[self createCatchNoteWithText:notes];
}

- (void)ShowNotes{
	NSMutableString *tags = [NSMutableString string];
	[tags appendString: CONFERENCE_TAG];
	[tags appendString: @" #"];

	//Now Getting Speaker Name
	NSString *speakername = [[TEDxAlcatrazGlobal nameStringFromJSONData:speakerDictionary] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
	[tags appendString: speakername];

	[CatchNotesLauncher showNotesMatchingText:tags fromViewController:self];
}

- (IBAction)switchNote_Clicked:(id)sender{
	switch (actionControls.selectedSegmentIndex) {
		case 0:
			[self addTextNote];
			break;
		case 1:
			[self ShowNotes];
			break;
	}
	[actionControls setSelectedSegmentIndex:-1];
}


#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -

- (void)dealloc {
	[self displayTabBar:NO];
	[actionControls release];
	[speakerDictionary release];
	[speakerToolBar release];
    [super dealloc];
}


@end
