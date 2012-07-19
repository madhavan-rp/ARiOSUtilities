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
@end

@implementation ARDataEntryViewController

@synthesize scrollView = _scrollView;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInputViewDidShow:) name: UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInputViewDidHide:) name: UIKeyboardDidHideNotification object:nil];
}

- (void)removeKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
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
- (void)adjustScrollViewForInputViewSize:(CGSize)inputViewSize
{
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, inputViewSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (BOOL)isActiveTextFieldHiddenByInputViewWithSize:(CGSize)inputViewSize
{
    CGRect unobscuredFrame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height - inputViewSize.height - self.inputAccessoryView.frame.size.height);
    CGPoint activeTextFieldBottomLeftPoint = CGPointMake(self.activeTextField.frame.origin.x,
                                                         self.activeTextField.frame.origin.y + self.activeTextField.frame.size.height);
    return !CGRectContainsPoint(unobscuredFrame, activeTextFieldBottomLeftPoint);
}

- (CGPoint)scrollPointForVisibleTextFieldWithInputViewSize:(CGSize)inputViewSize
{
    CGFloat activeTextFieldBottomY = self.activeTextField.frame.origin.y + self.activeTextField.frame.size.height;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;

    CGPoint scrollPoint = CGPointMake(0.0,
                                      self.scrollView.frame.origin.y +
                                      activeTextFieldBottomY -
                                      (screenHeight - (navigationBarHeight +
                                                      self.scrollViewHeaderHeight +
                                                      inputViewSize.height +
                                                      self.textFieldVisibilityPadding)));
    return scrollPoint;
}

#pragma mark - Keyboard Event Handlers
- (void)handleHideInputView:(id)sender
{
    [self.activeTextField resignFirstResponder];
}

- (void)handleInputViewDidShow:(NSNotification*)notification
{
    if (self.isInputViewShowing) return;

    self.isInputViewShowing = YES;

    NSDictionary* inputViewInformation = [notification userInfo];
    CGSize inputViewSize = [[inputViewInformation objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;

    // If a scroll view exists, adjust the content to compensate for the keyboard
    if (self.scrollView)
    {
        [self adjustScrollViewForInputViewSize:inputViewSize];
    }

    // If the active text field is hidden by the keyboard and our content exists within a scroll view, scroll the content to make it visible.
    if (self.scrollView && [self isActiveTextFieldHiddenByInputViewWithSize:inputViewSize])
    {
        CGPoint scrollPoint = [self scrollPointForVisibleTextFieldWithInputViewSize:inputViewSize];
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void)handleInputViewDidHide:(id)sender
{
    if (!self.isInputViewShowing) return;

    self.isInputViewShowing = NO;

    // Adjust the scroll view content to compensate for the lack of keyboard.
    if (self.scrollView)
    {
        self.scrollView.contentInset = UIEdgeInsetsZero;
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }

}

#pragma mark - Custom Toolbar Event Handlers
- (void)activateResponderWithTag:(NSInteger)tag withIncrement:(NSInteger)increment
{
    UIResponder* nextResponder = [[self.activeTextField superview] viewWithTag:tag];
    if (nextResponder && [nextResponder canBecomeFirstResponder])
    {
        [self.activeTextField resignFirstResponder];
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
