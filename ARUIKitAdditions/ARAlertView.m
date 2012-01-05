/*  ARAlertView.m
 *  ARiOSUtilities
 *
 *  Created by Adam Duke on 1/4/12.
 *  Copyright (c) 2012 appRenaissance, LLC. All rights reserved.
 *
 */

#import "ARAlertView.h"

@implementation ARAlertView

@synthesize completionBlock;

+ (id)alertView
{
    ARAlertView *sheet = [ARAlertView new];
    sheet.delegate = sheet;
    return sheet;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    completionBlock(buttonIndex);
    self.completionBlock = nil;
}

@end
