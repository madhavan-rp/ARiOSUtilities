/*  ARURLHelper.m
 *
 *  Created by Adam Duke on 7/6/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "NSData+FormEncoding.h"
#import "NSString+AppRenaissance.h"

@implementation  NSData (FormEncoding)

+ (NSData *)formEncodedDataFor:(NSDictionary *)requestParameters
{
    NSString *formEncodedParameterString = [NSString queryStringWithBase:nil parameters:requestParameters prefixed:NO];
    return [formEncodedParameterString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
