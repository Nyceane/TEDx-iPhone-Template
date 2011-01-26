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

#import "SpeakerDetailController.h"
#import "TEDxAlcatrazGlobal.h"

@implementation SpeakerDetailController

#pragma mark -

-(id)initWithSpeaker:(NSDictionary*)speakerJSONDictionary {
	self = [super initWithNibName:@"SpeakerDetailController" bundle:nil];
	
	if(self) {
		speakerDictionary = [speakerJSONDictionary retain];
	}
	
	return self;
}

#pragma mark -

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	self.navigationItem.title = [TEDxAlcatrazGlobal nameStringFromJSONData:speakerDictionary];
	
	//Set up WebView, just temporary to improve development speed
	NSString *urlAddress =	[NSString stringWithFormat:
							@"http://www.tedxapps.com/mobile/speaker/?SpeakerId=%d",
							[TEDxAlcatrazGlobal speakerIdFromJSONData:speakerDictionary]];

	[super loadURLString:urlAddress];
}

#pragma mark -

- (void)dealloc {
	[speakerDictionary release];
	
    [super dealloc];
}


@end
