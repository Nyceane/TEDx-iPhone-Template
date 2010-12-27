//
//  SpeakerDetailController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SpeakerDetailController.h"


@implementation SpeakerDetailController

@synthesize speakerDictionary, webView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	NSString *Name = [NSString stringWithFormat:
					  @"%@ %@",
					  [speakerDictionary objectForKey:@"FirstName"],
					  [speakerDictionary objectForKey:@"LastName"]];
	self.navigationItem.title = Name;
	
	//Set up WebView, just temporary to improve development speed
	NSString *urlAddress =	[NSString stringWithFormat:
							@"http://www.tedxapps.com/mobile/speaker/?SpeakerId=%@",
							[speakerDictionary objectForKey:@"SpeakerId"]
							 ];

	NSURL *url = [ NSURL URLWithString: urlAddress ];
	
	NSURLRequest *requestObj = [ NSURLRequest requestWithURL: url ];
		
	[ webView loadRequest: requestObj ];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[speakerDictionary release];
	[webView release];
    [super dealloc];
}


@end
