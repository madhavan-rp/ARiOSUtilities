/*  ARUserDefaultsHelper.h
 *
 *  Created by Adam Duke on 8/12/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Usability)

/* convenience method to save a given string for a given key */
+ (void)saveString:(NSString *)string forKey:(NSString *)key;

/* convenience method to return a string for a given key */
+ (NSString *)retrieveStringForKey:(NSString *)key;

/* convenience method to delete a value for a given key */
+ (void)deleteValueForKey:(NSString *)key;

@end
