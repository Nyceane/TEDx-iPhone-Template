//
//  InformationController.m
//  TEDxTransmedia
//
//  Created by Nyceane on 8/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InformationController.h"


@implementation InformationController
@synthesize webView, btnContact;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (void)viewDidLoad {
	//Load up the page
	NSString *urlAddress = @"http://www.tedxapps.com/mobile/about/?EventId=13";
	NSURL *url = [ NSURL URLWithString: urlAddress ];
	NSURLRequest *requestObj = [ NSURLRequest requestWithURL: url ];
	webView.scalesPageToFit = YES;
	[ webView loadRequest: requestObj ];

}

-(IBAction)btnEmail_Clicked
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:TEDxAlcatraz@gmail.com?subject=iPhone%20TEDxAlcatraz%20Question&body=Hello%20"]];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"webViewDidFinishLoad");
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
	[webView release];
    [super dealloc];
}


@end
