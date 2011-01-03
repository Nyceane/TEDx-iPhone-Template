//
//  SpeakerDetailController.h
//  TEDxTransmedia
//
//  Created by Nyceane on 8/21/10.  Updated by Michael May.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewControllerBaseClass.h"

@interface SpeakerDetailController : WebViewControllerBaseClass {
@private	
	NSDictionary *speakerDictionary;
}

-(id)initWithSpeaker:(NSDictionary*)speakerJSONDictionary;

@end
