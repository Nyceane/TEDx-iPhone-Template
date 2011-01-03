//
//  SpeakerViewController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10. Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpeakerViewController.h"

@interface  SpeakerViewController (InternalMethods)
@property (retain, nonatomic) IBOutlet UINavigationController* navigationController;
@end


@implementation SpeakerViewController

@synthesize navigationController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view addSubview:navigationController.view];
}

- (void)viewDidUnload {
    [super viewDidUnload];
	
	self.navigationController = nil;
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[navigationController release]; 	
	
    [super dealloc];
}


@end
