/*  UIView+Positioning.h
 *  ARiOSUtilities
 *
 *  Created by Adam Duke on 2/13/12.
 *  Copyright (c) 2012 appRenaissance, LLC. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface UIView (Positioning)

- (void)horizontallyCenterRelativeToView:(UIView *)view;
- (void)verticallyCenterRelativeToView:(UIView *)view;
- (void)centerRelativeToView:(UIView *)view;

@end
