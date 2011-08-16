/*  ARCredentialHelper.m
 *
 *  Created by Adam Duke on 6/20/10.
 *  Copyright 2010 Adam Duke. All rights reserved.
 *
 */

#import "ARCredentialHelper.h"
#import "ARCredentialKeys.h"
#import "ARUserDefaultsHelper.h"
#import "SynthesizeSingleton.h"

@implementation ARCredentialHelper

SYNTHESIZE_SINGLETON_FOR_CLASS(ARCredentialHelper);

/* saves the given accessKey to the standard NSUserDefaults with the key "CredentialKey_AccessKey"
**/
- (void)saveAccessKey:(NSString *)accessKey
{
	[[ARUserDefaultsHelper sharedARUserDefaultsHelper] saveString:accessKey forKey:CredentialKey_AccessKey];
}

/* saves the given secretKey to the standard NSUserDefaults with the key "CredentialKey_SecretKey"
**/
- (void)saveSecretKey:(NSString *)secretKey
{
	[[ARUserDefaultsHelper sharedARUserDefaultsHelper] saveString:secretKey forKey:CredentialKey_SecretKey];
}

/* Returns the value saved in the standard UserDefaults for the key "CredentialKey_AccessKey" */
- (NSString *)accessKey
{
	return [[ARUserDefaultsHelper sharedARUserDefaultsHelper] retrieveStringForKey:CredentialKey_AccessKey];
}

/* Returns the value saved in the standard UserDefaults for the key "CredentialKey_SecretKey" */
- (NSString *)secretKey
{
	return [[ARUserDefaultsHelper sharedARUserDefaultsHelper] retrieveStringForKey:CredentialKey_SecretKey];
}

/* Deletes the saved credentials from NSUserDefaults */
- (void)removeCredentials
{
	[[ARUserDefaultsHelper sharedARUserDefaultsHelper] deleteValueForKey:CredentialKey_AccessKey];
	[[ARUserDefaultsHelper sharedARUserDefaultsHelper] deleteValueForKey:CredentialKey_SecretKey];
}

@end