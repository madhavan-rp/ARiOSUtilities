/*  ARURLHelper.m
 *
 *  Created by Adam Duke on 7/6/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "ARURLHelper.h"

@implementation ARURLHelper

+ (NSString *)queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed
{
    /* Append base if specified. */
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    if(base)
    {
        [str appendString:base];
    }
    /* Append each name-value pair. */
    if(params)
    {
        int i;
        NSArray *names = [params allKeys];
        for(i = 0; i < [names count]; i++)
        {
            if(i == 0 && prefixed)
            {
                [str appendString:@"?"];
            }
            else if(i > 0)
            {
                [str appendString:@"&"];
            }
            NSString *name = [names objectAtIndex:i];
            NSString *value = [[params objectForKey:name] URLEncode];
            NSString *pair = [NSString stringWithFormat:@"%@=%@", name, value ];
            [str appendString:pair];
        }
    }

    return str;
}

+ (NSData *)formEncodedDataFor:(NSDictionary *)requestParameters
{
    NSString *formEncodedParameterString = [ARURLHelper queryStringWithBase:nil parameters:requestParameters prefixed:NO];
    return [formEncodedParameterString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
