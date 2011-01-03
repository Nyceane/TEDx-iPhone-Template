//
//  SpeakersResultTableViewCell.m
//  TEDxAlcatraz
//
//  Created by Michael May on 03/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SpeakersResultTableViewCell.h"

@implementation SpeakersResultTableViewCell

#pragma mark -

-(void)layoutSubviews {
	[super layoutSubviews];
	
	CGRect rect = CGRectMake(0, 0, kSpeakersTableRowHeight, kSpeakersTableRowHeight);
	[[self imageView] setFrame:rect];
	
	rect = self.textLabel.frame;
	rect.origin.x = kSpeakersTableRowHeight + 5;
	[[self textLabel] setFrame:rect];
	
	rect = self.detailTextLabel.frame;
	rect.origin.x = kSpeakersTableRowHeight + 5;
	[[self detailTextLabel] setFrame:rect];	
}

@end
