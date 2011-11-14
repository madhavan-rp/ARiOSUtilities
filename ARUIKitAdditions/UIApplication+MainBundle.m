/*  ARApplicationHelper.m
 *
 *  Created by Adam Duke on 10/14/11.
 *  Copyright 2010 Adam Duke. All rights reserved.
 *
 */

#import "UIApplication+MainBundle.h"

@implementation UIApplication (MainBundle)

- (NSString *)bundleValueForKey:(NSString *)key
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    return [info objectForKey:key];
}

- (NSString *)version
{
    return [self bundleValueForKey:@"CFBundleShortVersionString"];
}

- (NSString *)buildNumber
{
    return [self bundleValueForKey:@"CFBundleVersion"];
}

- (NSString *)applicationVersion
{
    return [NSString stringWithFormat:@"%@ (%@)", [self version], [self buildNumber]];
}

- (NSString *)applicationName
{
    return [self bundleValueForKey:@"CFBundleDisplayName"];
}
@end
