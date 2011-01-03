//
//  SpeakerDetailController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
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
