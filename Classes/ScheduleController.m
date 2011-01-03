//
//  ScheduleController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScheduleController.h"

#import "TEDxAlcatrazGlobal.h"

#define kTEDxAppsEventURL @"http://www.tedxapps.com/mobile/schedule/?EventId=13"

@implementation ScheduleController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[super loadURLString:kTEDxAppsEventURL];
}

@end
