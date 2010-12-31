//
//  TEDxAlcatrazAppDelegate.h
//  TEDxAlcatraz
//
//  Created by Nyceane on 11/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

// A way to remove the debugging to the console from the app when not in debug build, making the app
// smaller and faster. It also adds the extra logging I have been meaning to drop in for ages which is 
// logging the function and line too. We could also add __FILE__ but we probably don't need it. 
// From http://iphoneincubator.com/blog/tag/nslog
// DLog is almost a drop-in replacement for DLog  
// DLog();
// DLog(@"here");  
// DLog(@"value: %d", x);  
// Unfortunately this doesn't work DLog(aStringVariable); you have to do this instead DLog(@"%@", aStringVariable);  
#ifdef DEBUG  
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else  
#define DLog(...)  
#endif  

@interface TEDxAlcatrazAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
