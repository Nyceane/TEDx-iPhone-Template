/*
 *  TEDxAlcatrazGlobal.h
 *  TEDxAlcatraz
 *
 *  Created by Michael May on 03/01/2011.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

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

#ifdef DEBUG 
#define DAssert(condition, desc) NSAssert(condition, desc)
#else
#define DAssert(condition, desc) 
#endif

@interface TEDxAlcatrazGlobal : NSObject

+(NSString*)nameStringFromJSONData:(NSDictionary*)JSONDictonary;

+(NSString*)titleFromJSONData:(NSDictionary*)JSONDictionary;

+(NSString*)photoURLFromJSONData:(NSDictionary*)JSONDictionary;

+(NSInteger)speakerIdFromJSONData:(NSDictionary*)JSONDictionary;

@end