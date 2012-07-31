//
//  ARSpringButton.h
//  ARiOSUtilities
//
//  Created by Kevin Jenkins on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// Reference: http://khanlou.com/2012/01/dampers-and-their-role-in-physical-models/

@interface ARSpringButton : UIButton

@property (assign, nonatomic) CGPoint stopPosition;
@property (assign, nonatomic) CGPoint startPosition;
@property (assign, nonatomic) CGFloat alpha;
@property (assign, nonatomic) CGFloat omega;
@property (assign, nonatomic) CGFloat durationRelease;
@property (assign, nonatomic) CGFloat durationReset;
@property (assign, nonatomic) BOOL isReleased;

- (void) releaseSpring;
- (void) resetSpring;

@end
