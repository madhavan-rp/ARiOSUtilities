/*  UIView+Positioning.m
 *  ARiOSUtilities
 *
 *  Created by Adam Duke on 2/13/12.
 *  Copyright (c) 2012 appRenaissance, LLC. All rights reserved.
 *
 */

#import "UIView+Positioning.h"

@implementation UIView (Positioning)

- (void)horizontallyCenterRelativeToView:(UIView *)view
{
    CGFloat newXOrigin = view.center.x - (self.frame.size.width / 2);
    self.frame = CGRectMake(newXOrigin, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)verticallyCenterRelativeToView:(UIView *)view
{
    CGFloat newYOrigin = view.center.y - (self.frame.size.height / 2);
    self.frame = CGRectMake(self.frame.origin.x, newYOrigin, self.frame.size.width, self.frame.size.height);
}

- (void)centerRelativeToView:(UIView *)view
{
    [self horizontallyCenterRelativeToView:view];
    [self verticallyCenterRelativeToView:view];
}

@end
