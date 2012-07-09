//
//  UIColor+HexString.h
//
//  Created by Kevin Clough on 6/26/12.
//  Copyright (c) 2012 appRenaissance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (NSString *)hexColorFromUIColor:(UIColor *)color;

@end
