/*  ARAlertView.h
 *  ARiOSUtilities
 *
 *  Created by Adam Duke on 1/4/12.
 *  Copyright (c) 2012 appRenaissance, LLC. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@interface ARAlertView : UIAlertView <UIAlertViewDelegate>

+ (id)alertView;

@property (nonatomic, copy) void (^completionBlock)(NSUInteger index);

@end
