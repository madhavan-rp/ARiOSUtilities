/*  ARCredentialHelper.h
 *
 *  Created by Adam Duke on 6/20/10.
 *  Copyright 2010 Adam Duke. All rights reserved.
 *
 */

@interface ARCredentialHelper : NSObject {}

+ (ARCredentialHelper *)sharedARCredentialHelper;

/* Saves the value of the given accessKey */
- (void)saveAccessKey:(NSString *)accessKey;

/* Saves the value of the given secretKey */
- (void)saveSecretKey:(NSString *)secretKey;

/* Saves the value of the given userId */
- (void)saveUserId:(NSString *)userId;

/* Returns the saved accessKey */
- (NSString *)accessKey;

/* Returns the saved secretKey */
- (NSString *)secretKey;

/* Returns the saved userId */
- (NSString *)userId;

/* Removes any saved credential information */
- (void)removeCredentials;

@end
