/*  NSDate+Comparison.h
 *
 *  Created by Odin on 6/18/12.
 *  Copyright (c) 2012 appRenaissance. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface NSDate (Comparison)

+ (BOOL)date:(NSDate *)date isBetweenDate:(NSDate *)beginDate andDate:(NSDate *)endDate;

@end
