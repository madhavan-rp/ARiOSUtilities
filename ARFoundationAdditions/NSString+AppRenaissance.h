/*  NSString+AppRenaissance.h
 *
 *  Created by Scott Wasserman on 5/5/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface NSString (htmlAdditions)
- (NSString *)escapeHTML;
@end

@interface NSString (URLEncoding)
- (NSString *)URLEncode;
- (NSString *)URLDecode;
+ (NSString *)queryStringWithBase:(NSString *)base parameters:(NSDictionary *)params prefixed:(BOOL)prefixed;
@end

@interface NSString (whitespaceAdditions)
- (NSString *)stringByTrimmingWhitspace;
- (BOOL)isBlank;
@end
