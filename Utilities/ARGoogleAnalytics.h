/*  GoogleAnalytics.h
 *  Vineloop
 *
 *  Created by Scott Wasserman on 10/15/10.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface ARGoogleAnalytics : NSObject {}

+ (void)startTrackerForApplication:(NSString *)applicationName accountId:(NSString *)accountId;
+ (void)stopTrackerForApplication:(NSString *)applicationName;
+ (void)trackAction:(NSString *)action forApplication:(NSString *)applicationName;
+ (void)trackPageView:(NSString *)pageName;
@end
