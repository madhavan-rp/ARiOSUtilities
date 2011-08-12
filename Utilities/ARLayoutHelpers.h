/*  LayoutHelpers.h
 *
 *  Created by Scott Wasserman on 4/16/10.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface ARLayoutHelpers : NSObject {}

+ (NSInteger)calculateHeightScaleImageProportionally:(NSInteger)originalWidth originalHeight:(NSInteger)originalHeight newWidth:(NSInteger)newWidth;
+ (CGSize)CGSizeMakeForText:(NSString *)text withFont:(UIFont *)font width:(CGFloat)width;
+ (CGSize)CGSizeMakeForSingleLineLabel:(UILabel *)label width:(CGFloat)width;
+ (CGSize)CGSizeMakeForMultiLineLabel:(UILabel *)label width:(CGFloat)width;
+ (CGSize)CGSizeMakeForLabel:(UILabel *)label width:(CGFloat)width height:(CGFloat)height;

@end
