/*  UIView+ResignResponder.m
 *
 *  Created by Scott Wasserman on 5/5/11.
 *  Copyright 2011 appRenaissance, LLC. All rights reserved.
 *
 */

#import "UIView+ResignResponder.h"

@implementation UIView (ResignResponder)

- (void)dismissKeyboardIfPresent
{
	for(UIView *subview in self.subviews)
	{
		if([subview isFirstResponder])
		{
			[subview resignFirstResponder];
		}
	}
}

@end