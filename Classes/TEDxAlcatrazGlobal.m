/*
 *  TEDxAlcatrazGlobal.m
 *  TEDxAlcatraz
 *
 *  Created by Michael May on 03/01/2011.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#import "TEDxAlcatrazGlobal.h"

@implementation TEDxAlcatrazGlobal

+(NSString*)nameStringFromJSONData:(NSDictionary*)JSONDictionary {
	DAssert([[JSONDictionary objectForKey:@"FirstName"] isKindOfClass:[NSString class]], @"FirstName is not a string");
	DAssert([[JSONDictionary objectForKey:@"LastName"] isKindOfClass:[NSString class]], @"LastName Id is not a string");
	
	//get the speaker name
	return [NSString stringWithFormat:
					  @"%@ %@",
					  [JSONDictionary objectForKey:@"FirstName"],
					  [JSONDictionary objectForKey:@"LastName"]];	
}

+(NSString*)titleFromJSONData:(NSDictionary*)JSONDictionary {
	DAssert([[JSONDictionary objectForKey:@"Title"] isKindOfClass:[NSString class]], @"Title is not a string");
	
	return [JSONDictionary objectForKey:@"Title"];	
}

+(NSString*)photoURLFromJSONData:(NSDictionary*)JSONDictionary {
	DAssert([[JSONDictionary objectForKey:@"PhotoURL"] isKindOfClass:[NSString class]], @"PhotoURL is not a string");
	
	return [JSONDictionary objectForKey:@"PhotoURL"];	
}

+(NSInteger)speakerIdFromJSONData:(NSDictionary*)JSONDictionary {
	DAssert([[JSONDictionary objectForKey:@"SpeakerId"] isKindOfClass:[NSNumber class]], @"Speaker Id is not a number");
	
	return [[JSONDictionary objectForKey:@"SpeakerId"] intValue];
}

@end

