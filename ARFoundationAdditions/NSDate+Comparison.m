/*  NSDate+Comparison.m
 *
 *  Created by Odin on 6/18/12.
 *  Copyright (c) 2012 appRenaissance. All rights reserved.
 *
 */

#import "NSDate+Comparison.h"

@implementation NSDate (Comparison)

+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate
{
    if([date compare:beginDate] == NSOrderedAscending)
    {
        return NO;
    }
    if([date compare:endDate] == NSOrderedDescending)
    {
        return NO;
    }

    return YES;
}

@end
