/*
 The MIT License
 
 Copyright (c) 2010 Peter Ma
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */
/*
 *  TEDxAlcatrazGlobal.h
 *  TEDxAlcatraz
 *
 *  Created by Michael May on 03/01/2011.
 *  Copyright 2011 Michael May. All rights reserved.
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