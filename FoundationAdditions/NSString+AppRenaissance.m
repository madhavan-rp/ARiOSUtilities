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
    NSString *URLEncodedString =
        (NSString *) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                             (CFStringRef) self,
                                                             NULL,
                                                             CFSTR(":/?#[]@!$&'()*+,;="),
                                                             kCFStringEncodingUTF8);
    return [URLEncodedString autorelease];
}

- (NSString *)URLDecode
{
    NSString *URLDecodeedString =
        (NSString *) CFURLCreateStringByReplacingPercentEscapes( kCFAllocatorDefault,
                                                                 (CFStringRef) self,
                                                                 CFSTR(":/?#[]@!$&'()*+,;=") );
    return [URLDecodeedString autorelease];
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
