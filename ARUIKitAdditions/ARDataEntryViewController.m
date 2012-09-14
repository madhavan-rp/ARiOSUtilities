//
//  ARDataEntryViewController.m
//  ARiOSUtilities
//
//  Created by Aaron Keuhler and Kevin Jenkins on 7/19/12.
//  Copyright (c) 2012 appRenaissance, LLC. All rights reserved.
//

#import "ARDataEntryViewController.h"

@interface ARDataEntryViewController ()
- (void)handleNextToolbarButtonTap:(id)sender;
- (void)handlePrevToolbarButtonTap:(id)sender;
- (void)handleDoneToolbarButtonTap:(id)sender;
- (CGRect)activeTextFieldFrameWithPaddingForInputViewSize:(CGSize)inputViewSize;
@end

@implementation ARDataEntryViewController

@synthesize scrollView = _scrollView;
@synthesize contentView = _contentView;
@synthesize activeTextField = _activeTextField;
@synthesize tapRecognizer = _tapRecognizer;
@synthesize isInputViewShowing = _isInputViewShowing;
@synthesize shouldHideInputViewOnTapOutside = _shouldHideInputViewOnTapOutside;

@synthesize disabledControlAlpha = _disabledControlAlpha;
@synthesize enabledControlAlpha = _enabledControlAlpha;
@synthesize textFieldVisibilityPadding = _textFieldVisibilityPadding;
@synthesize scrollViewHeaderHeight = _scrollViewHeaderHeight;

@synthesize previousBarButtonText = _previousBarButtonText;
@synthesize nextBarButtonText = _nextBarButtonText;
@synthesize barButtonItemStyle = _barButtonItemStyle;
@synthesize toolbarHeight = _toolbarHeight;
@synthesize toolbarStyle = _toolbarStyle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - Setup Methods
- (void)doSetupWithDefaultValues
{
    self.shouldHideInputViewOnTapOutside = YES;

    // default values
    self.disabledControlAlpha = 0.25f;
    self.enabledControlAlpha = 1.0f;
    self.textFieldVisibilityPadding = 5.0f;
    self.scrollViewHeaderHeight = 0.0f;
    self.previousBarButtonText = [NSString stringWithFormat:@"Prev"];
    self.nextBarButtonText = [NSString stringWithFormat:@"Next"];
    self.barButtonItemStyle = UIBarButtonItemStyleBordered;
    self.toolbarHeight = 30.0f;
    self.toolbarStyle = UIBarStyleBlackTranslucent;
}
- (void)addHideInputViewGesture
{
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleHideInputView:)];
    self.tapRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.tapRecognizer];
}

- (void)removeHideInputViewGesture
{
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

- (void)addKeyboardNotifications
{
    /* Input views such as the keyboard and picker both use the UIKeyboard... series of keys */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInputViewWillShow:) name: UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInputViewWillHide:) name: UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInputViewDidShow:) name: UIKeyboardDidShowNotification object:nil];
}

- (void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

#pragma mark - UIView Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self doSetupWithDefaultValues];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addKeyboardNotifications];
    [self addHideInputViewGesture];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self removeKeyboardNotifications];
    [self removeHideInputViewGesture];
}

#pragma mark - Enable/Disable Controls
- (void)disableControl:(UIControl *)control
{
    control.userInteractionEnabled = NO;
    control.alpha = self.disabledControlAlpha;
}

- (void)enableControl:(UIControl *)control
{
    control.userInteractionEnabled = YES;
    control.alpha = self.enabledControlAlpha;
}

#pragma mark - Interface Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Event Handler Helper Methods
- (void)handleHideInputView:(id)sender
{
    [self.activeTextField resignFirstResponder];
}
- (CGRect)activeTextFieldFrameWithPaddingForInputViewSize:(CGSize)inputViewSize
{
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    CGRect frameInScrollView = [self.activeTextField.superview convertRect:self.activeTextField.frame toView:self.contentView];

    return CGRectMake(frameInScrollView.origin.x,
                      frameInScrollView.origin.y,
                      frameInScrollView.size.width,
                      frameInScrollView.size.height - (frameInScrollView.size.height/2.0) + (inputViewSize.height/2.0) - navigationBarHeight - statusBarHeight + self.activeTextField.inputAccessoryView.frame.size.height);
}
- (void)adjustScrollViewForHeightChange:(CGFloat)heightChange
{
    CGRect scrollViewFrame = self.scrollView.frame;

    scrollViewFrame.size.height += heightChange;

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.scrollView setFrame:scrollViewFrame];
    [UIView commitAnimations];
}

#pragma mark - Keyboard Event Handlers
- (void)handleInputViewWillHide:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];

    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;

    [self adjustScrollViewForHeightChange:keyboardSize.height-tabBarHeight];

    self.isInputViewShowing = NO;
}

- (void)handleInputViewWillShow:(NSNotification*)notification
{
    if (self.isInputViewShowing) return;

    NSDictionary *userInfo = [notification userInfo];

    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;

    [self adjustScrollViewForHeightChange:-(keyboardSize.height - tabBarHeight)];

    [self.activeTextField becomeFirstResponder];

}
- (void)handleInputViewDidShow:(NSNotification*)notification
{
    if (self.isInputViewShowing) return;
    NSDictionary *userInfo = [notification userInfo];

    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect activeTextFieldAndPadding = [self activeTextFieldFrameWithPaddingForInputViewSize:keyboardSize];

    [self.scrollView scrollRectToVisible:activeTextFieldAndPadding animated:YES];
    self.isInputViewShowing = YES;
}

#pragma mark - Custom Toolbar Event Handlers
- (void)activateResponderWithTag:(NSInteger)tag withIncrement:(NSInteger)increment
{
    UIResponder* nextResponder = [self.contentView viewWithTag:tag];
    if (nextResponder && [nextResponder canBecomeFirstResponder])
    {
        [nextResponder becomeFirstResponder];
        return;
    }
    if (nextResponder)
    {
        [self activateResponderWithTag:tag+increment withIncrement:increment];
        return;
    }

    [self.activeTextField resignFirstResponder];
}

- (void)handleNextToolbarButtonTap:(id)sender
{
    [self activateResponderWithTag:self.activeTextField.tag + 1 withIncrement:1];
}

- (void)handlePrevToolbarButtonTap:(id)sender
{
    if ([self.activeTextField tag] < 2)
    {
        NSLog(@"ARDataEntryViewController Error: All data fields must have tags greater than or equal to 2 in order to avoid collisions with default tags.");
        [self.activeTextField resignFirstResponder];
        return;
    }
    [self activateResponderWithTag:self.activeTextField.tag - 1 withIncrement:-1];
}

- (void)handleDoneToolbarButtonTap:(id)sender
{
    [self.activeTextField resignFirstResponder];
}

#pragma mark - Input Field Navigation Toolbar Creation
- (UIBarButtonItem*)previousButton
{
    UIBarButtonItem* previousBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.previousBarButtonText
                                                                              style:self.barButtonItemStyle
                                                                             target:self
                                                                             action:@selector(handlePrevToolbarButtonTap:)];
    return previousBarButtonItem;
}

- (UIBarButtonItem*)nextButton
{
    UIBarButtonItem* nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.nextBarButtonText
                                                                          style:self.barButtonItemStyle
                                                                         target:self
                                                                         action:@selector(handleNextToolbarButtonTap:)];
    return nextBarButtonItem;
}

- (UIBarButtonItem*)spacer
{
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:nil
                                                                            action:nil];
    return spacer;
}

- (UIBarButtonItem*)doneButton
{
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                       target:self
                                                                                       action:@selector(handleDoneToolbarButtonTap:)];
    return doneBarButtonItem;
}

- (UIToolbar*)inputFieldNavigationToolBar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.activeTextField.frame.origin.x, self.activeTextField.frame.origin.y, self.activeTextField.frame.size.width, self.toolbarHeight)];
    toolbar.barStyle = self.toolbarStyle;
    toolbar.items = [NSArray arrayWithObjects:[self previousButton], [self nextButton], [self spacer], [self doneButton], nil];
    return toolbar;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = textField;
    self.activeTextField.inputAccessoryView = [self inputFieldNavigationToolBar];

    UIView *superView = self.activeTextField.superview.superview;
    if ([[[self.activeTextField superview] superview] isKindOfClass:[UITableViewCell class]])
    {
        UITableViewCell *tableViewCell = (UITableViewCell*)self.activeTextField.superview.superview;
        UITableView *tableView = (UITableView*)tableViewCell.superview;
        NSIndexPath *indexPath = [tableView indexPathForCell:tableViewCell];

        CGRect frameInScrollView = [tableView convertRect:tableViewCell.frame toView:self.contentView];

        [self.scrollView scrollRectToVisible:frameInScrollView animated:YES];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"])
    {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:[UIControl class]])
    {
        return NO;
    }
    return YES;
}

@end
