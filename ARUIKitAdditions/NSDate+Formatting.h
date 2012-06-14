//
//  NSDate_Formatting.h
//  This Is Hardcore
//
//  Created by Odin on 6/13/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Formatting)

- (NSString *)formatWithString:(NSString *)format;
- (NSString *)formatWithStyle:(NSDateFormatterStyle)style;
- (NSString *)distanceOfTimeInWords;
- (NSString *)distanceOfTimeInWords:(NSDate *)date;

@end
