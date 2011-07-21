/*  ARLayoutHelpers.m
 *  Vineloop
 *
 *  Created by Scott Wasserman on 4/16/10.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "ARLayoutHelpers.h"

@implementation ARLayoutHelpers

+ (NSInteger)calculateHeightScaleImageProportionally:(NSInteger)originalWidth originalHeight:(NSInteger)originalHeight newWidth:(NSInteger)newWidth
{
	CGFloat imageRatio = (CGFloat)originalWidth  / (CGFloat)originalHeight;
	NSInteger newHeight = trunc(newWidth / imageRatio);
	return newHeight;
}

+ (CGSize)CGSizeMakeForText:(NSString *)text withFont:(UIFont *)font width:(CGFloat)width
{
	return [text sizeWithFont:font
	        constrainedToSize:CGSizeMake(width, 3000)
	            lineBreakMode:UILineBreakModeTailTruncation];
}

+ (CGSize)CGSizeMakeForSingleLineLabel:(UILabel *)label width:(CGFloat)width
{
	CGRect frame = label.frame;
	CGFloat height = frame.size.height;
	return [label.text sizeWithFont:label.font
	              constrainedToSize:CGSizeMake(width, height)
	                  lineBreakMode:label.lineBreakMode];
}

+ (CGSize)CGSizeMakeForMultiLineLabel:(UILabel *)label width:(CGFloat)width
{
	return [label.text sizeWithFont:label.font
	              constrainedToSize:CGSizeMake(width, 3000)
	                  lineBreakMode:label.lineBreakMode];
}

+ (CGSize)CGSizeMakeForLabel:(UILabel *)label width:(CGFloat)width height:(CGFloat)height
{
	return [label.text sizeWithFont:label.font
	              constrainedToSize:CGSizeMake(width, height)
	                  lineBreakMode:label.lineBreakMode];
}

@end
