/*  NSString+AppRenaissance.m
 *
 *  Created by Scott Wasserman on 5/5/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "NSString+AppRenaissance.h"

@implementation NSString (htmlAdditions)
- (NSString *)escapeHTML
{
    /* This is pretty weak escaping, but should be enough for our needs */
    NSString *escaped = [self stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    escaped = [escaped stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    return escaped;
}

@end

@implementation NSString (URLEncoding)
- (NSString *)URLEncode
{
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                  (__bridge CFStringRef)self,
                                                                  NULL,
                                                                  CFSTR(":/?#[]@!$&'()*+,;="),
                                                                  kCFStringEncodingUTF8);
    return [NSString stringWithString:(__bridge_transfer NSString *)encoded];
}

- (NSString *)URLDecode
{
    CFStringRef decoded = CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                      (__bridge CFStringRef)self,
                                                                      CFSTR(":/?#[]@!$&'()*+,;=") );
    return [NSString stringWithString:(__bridge_transfer NSString *)decoded];
}

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
            if([[params objectForKey:name] isKindOfClass:[NSArray class]])
            {
                NSArray *array = [params objectForKey:name];
                [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
                 {
                     NSString *value = (NSString *)obj;
                     NSString *pair = [NSString stringWithFormat:@"%@[]=%@", name, value ];
                     [str appendString:pair];
                     if(obj != [array lastObject])
                     {
                         [str appendString:@"&"];
                     }
                 }];
            }
            else
            {
                NSString *value = [[params objectForKey:name] URLEncode];
                NSString *pair = [NSString stringWithFormat:@"%@=%@", name, value ];
                [str appendString:pair];
            }
        }
    }
    return [NSString stringWithString:str];
}

@end

@implementation NSString (whitespaceAdditions)
- (NSString *)stringByTrimmingWhitspace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)isBlank
{
    NSString *trimmed = [self stringByTrimmingWhitspace];
    return ([trimmed length] == 0);
}

@end
