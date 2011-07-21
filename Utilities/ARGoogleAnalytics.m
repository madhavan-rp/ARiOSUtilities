/*  GoogleAnalytics.m
 *  Vineloop
 *
 *  Created by Scott Wasserman on 10/15/10.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "ARGoogleAnalytics.h"
#import "GANTracker.h"

/* Dispatch period in seconds */
#define kDispatchPeriod 10

@implementation ARGoogleAnalytics

static GANTracker *tracker;

+ (void)startTrackerForApplication:(NSString *)applicationName accountId:(NSString *)accountId
{
	tracker = [GANTracker sharedTracker];
	[tracker startTrackerWithAccountID:accountId
	                    dispatchPeriod:kDispatchPeriod
	                          delegate:nil];
	[self trackAction:@"Started app" forApplication:applicationName];
}

+ (void)stopTrackerForApplication:(NSString *)applicationName
{
	[self trackAction:@"Exited app" forApplication:applicationName];
	[[GANTracker sharedTracker] stopTracker];
}

+ (void)trackAction:(NSString *)action forApplication:(NSString *)applicationName
{
	NSError *error;
	if(![tracker trackEvent:[NSString stringWithFormat:@"%@ iphone", applicationName]
	                 action:action
	                  label:@""
	                  value:0
	              withError:&error])
	{
#ifdef DEBUG
		NSLog(@"Failed to track event %@ because %@", action, [error localizedFailureReason]);
#endif
	}
}

+ (void)trackPageView:(NSString *)pageName
{
	NSError *error;
	if(![tracker trackPageview:[NSString stringWithFormat:@"/%@", pageName]
	                 withError:&error])
	{
#ifdef DEBUG
		NSLog(@"Failed to track page view %@ because %@", pageName, [error localizedFailureReason]);
#endif
	}
}

@end
