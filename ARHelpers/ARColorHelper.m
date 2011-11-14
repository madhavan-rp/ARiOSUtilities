//
//  ARColorHelper.m
//  AllFanz
//
//  Created by Scott Wasserman on 8/23/11.
//  Copyright 2011 appRenaissance LLC. All rights reserved.
//

#import "ARColorHelper.h"


@implementation ARColorHelper
+ (NSString *)buildHexColorFromUIColor:(UIColor*)color
{
    const CGFloat* components = CGColorGetComponents(color.CGColor);
    NSString *hexString = [NSString stringWithFormat:@"%02X%02X%02X", (int)(components[0]*255.0),(int)(components[1]*255.0),(int)(components[2]*255.0)];
    return hexString;
}
@end
