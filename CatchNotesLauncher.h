/*Copyright 2011 Catch.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.*/
//
//  CatchNotesLauncher.h
//
//  Created by Jeff Meininger on 8/2/10.  Updated By Peter Ma
//  Copyright 2011 Catch.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CatchNotesLauncher : UIViewController <UIWebViewDelegate>
{
	NSError *error;
}
+ (void)createNewNoteWithText:(NSString*)text 
	fromViewController:(UIViewController*)viewController;

+ (void)createNewNoteWithText:(NSString*)text cursorAt:(NSInteger)offset 
	bounceOnSave:(NSString*)saveUri bounceOnCancel:(NSString*)cancelUri 
	fromViewController:(UIViewController*)viewController;

+ (void)showNotesMatchingText:(NSString*)text 
	fromViewController:(UIViewController*)viewController;

+ (void)showNotesWithTag:(NSString*)tag 
	fromViewController:(UIViewController*)viewController;

@end
