//
//  InformationController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InformationController.h"
#import "TEDxAlcatrazGlobal.h"

#define kTEDxInformationURL @"http://www.tedxapps.com/mobile/about/?EventId=13"
#define kTEDxMailToURL @"mailto:TEDxAlcatraz@gmail.com?subject=iPhone%20TEDxAlcatraz%20Question&body=Hello%20"

@implementation InformationController

@synthesize btnContact;

- (void)viewDidLoad  {
	[super loadURLString:kTEDxInformationURL];
}

-(IBAction)btnEmail_Clicked {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:kTEDxMailToURL]];
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
