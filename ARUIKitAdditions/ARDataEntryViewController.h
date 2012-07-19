//
//  ARDataEntryViewController.h
//  ARiOSUtilities
//
//  Created by Kevin Jenkins on 7/19/12.
//  Copyright (c) 2012 appRenaissance, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARDataEntryViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView* scrollView;
@property (strong, nonatomic) UITextField* activeTextField;
@property (strong, nonatomic) UIGestureRecognizer* tapRecognizer;
@property (assign, nonatomic) BOOL isInputViewShowing;
@property (assign, nonatomic) BOOL shouldHideInputViewOnTapOutside;

@property (assign, nonatomic) CGFloat disabledControlAlpha;
@property (assign, nonatomic) CGFloat enabledControlAlpha;
@property (assign, nonatomic) CGFloat textFieldVisibilityPadding;
@property (assign, nonatomic) CGFloat scrollViewHeaderHeight;

@property (strong, nonatomic) NSString* previousBarButtonText;
@property (strong, nonatomic) NSString* nextBarButtonText;
@property (assign, nonatomic) UIBarButtonItemStyle barButtonItemStyle;
@property (assign, nonatomic) UIBarStyle toolbarStyle;
@property (assign, nonatomic) CGFloat toolbarHeight;

- (void)disableControl:(UIControl *)control;
- (void)enableControl:(UIControl *)control;

@end
