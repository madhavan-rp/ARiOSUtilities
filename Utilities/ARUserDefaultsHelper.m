/*  ARUserDefaultsHelper.m
 *
 *  Created by Adam Duke on 8/12/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "ARUserDefaultsHelper.h"
#import "SynthesizeSingleton.h"

@implementation ARUserDefaultsHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(ARUserDefaultsHelper);

/* convenience method to save a given string for a given key */
- (void)saveString:(NSString *)string forKey:(NSString *)key
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:string forKey:key];
	[defaults synchronize];
}

/* convenience method to return a string for a given key */
- (NSString *)retrieveStringForKey:(NSString *)key
{
	return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

/* convenience method to delete a value for a given key */
- (void)deleteValueForKey:(NSString *)key
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults removeObjectForKey:key];
	[defaults synchronize];
}

@end
