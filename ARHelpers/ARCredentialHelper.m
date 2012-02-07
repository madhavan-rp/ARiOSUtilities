/*  ARCredentialHelper.m
 *
 *  Created by Adam Duke on 6/20/10.
 *  Copyright 2010 Adam Duke. All rights reserved.
 *
 */

#import "ARCredentialHelper.h"
#import "ARCredentialKeys.h"
#import "NSUserDefaults+Usability.h"

@implementation ARCredentialHelper

+ (ARCredentialHelper *)sharedARCredentialHelper
{
    static ARCredentialHelper *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                      sharedInstance = [[ARCredentialHelper alloc] init];

                      /* Do any other initialisation stuff here */
                  });
    return sharedInstance;
}

/* saves the given accessKey to the standard NSUserDefaults with the key "CredentialKey_AccessKey"
**/
- (void)saveAccessKey:(NSString *)accessKey
{
    [NSUserDefaults saveObject:accessKey forKey:CredentialKey_AccessKey];
}

/* saves the given secretKey to the standard NSUserDefaults with the key "CredentialKey_SecretKey"
**/
- (void)saveSecretKey:(NSString *)secretKey
{
    [NSUserDefaults saveObject:secretKey forKey:CredentialKey_SecretKey];
}

/* saves the given accessKey to the standard NSUserDefaults with the key "CredentialKey_AccessKey"
**/
- (void)saveUserId:(NSString *)userId
{
    [NSUserDefaults saveObject:userId forKey:CredentialKey_UserIdKey];
}

/* Returns the value saved in the standard UserDefaults for the key "CredentialKey_AccessKey" */
- (NSString *)accessKey
{
    return [NSUserDefaults retrieveObjectForKey:CredentialKey_AccessKey];
}

/* Returns the value saved in the standard UserDefaults for the key "CredentialKey_SecretKey" */
- (NSString *)secretKey
{
    return [NSUserDefaults retrieveObjectForKey:CredentialKey_SecretKey];
}

/* Returns the value saved in the standard UserDefaults for the key "CredentialKey_SecretKey" */
- (NSString *)userId
{
    return [NSUserDefaults retrieveObjectForKey:CredentialKey_UserIdKey];
}

/* Deletes the saved credentials from NSUserDefaults */
- (void)removeCredentials
{
    [NSUserDefaults deleteValueForKey:CredentialKey_AccessKey];
    [NSUserDefaults deleteValueForKey:CredentialKey_SecretKey];
    [NSUserDefaults deleteValueForKey:CredentialKey_UserIdKey];
}

@end