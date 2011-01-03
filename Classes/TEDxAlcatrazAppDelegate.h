//
//  TEDxAlcatrazAppDelegate.h
//  TEDxAlcatraz
//
//  Created by Nyceane on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h> 

#import "TEDxAlcatrazGlobal.h"

@interface TEDxAlcatrazAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
