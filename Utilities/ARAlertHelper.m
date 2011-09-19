//
//  ARAlertHelper.m
//  Vineloop
//
//  Created by Aaron Kuehler on 9/19/11.
//  Copyright 2011 appRenaissance, LLC. All rights reserved.
//

#import "ARAlertHelper.h"

@implementation ARAlertHelper

+(void)alertWithMessage:(NSString*)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end
