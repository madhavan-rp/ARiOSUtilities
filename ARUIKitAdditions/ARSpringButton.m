//
//  ARSpringButton.m
//  ARiOSUtilities
//
//  Created by Kevin Jenkins on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ARSpringButton.h"

@interface ARSpringButton ()

@end

@implementation ARSpringButton

@synthesize stopPosition = _stopPosition;
@synthesize startPosition = _startPosition;
@synthesize alpha = _alpha;
@synthesize omega = _omega;
@synthesize isReleased = _isReleased;
@synthesize durationRelease = _durationRelease;
@synthesize durationReset = _durationReset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWithDefaults];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setupWithDefaults];
    }
    return self;
}

- (void) setupWithDefaults
{
    self.isReleased = NO;
    self.alpha = 0.055; //  "speed damping" this can override the bouncing. .5 is very strong
    self.omega = 0.08; // "bounciness" .5 is SUPER bouncy.
    self.durationRelease = 2.0f;
    self.durationReset = 0.35f;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - Motion Methods
- (void) releaseSpring
{
    self.isReleased = YES;
    
    // Courtesy of Soroush Khanlou :: http://khanlou.com/2012/01/cakeyframeanimation-make-it-bounce/
    int steps = 100;
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:steps];
    double value = 0;
    float e = 2.71;
    for (int t = 0; t < steps; t++) {
        value = self.startPosition.y * pow(e, -self.alpha*t) * cos(self.omega*t) + self.stopPosition.y;
        [values addObject:[NSNumber numberWithFloat:value]];
    }
    
    // **********************************
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    keyFrameAnimation.duration = self.durationRelease;
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.values = values;
    
    [[self layer] addAnimation:keyFrameAnimation forKey:@"releaseSpring"];
}
- (void) resetSpring
{
    self.isReleased = NO;

    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    keyFrameAnimation.duration = self.durationReset;
    keyFrameAnimation.delegate = self;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:self.stopPosition.y], 
                                [NSNumber numberWithFloat:self.startPosition.y], nil];
    
    [[self layer] addAnimation:keyFrameAnimation forKey:@"resetSpring"];    

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self setButtonPosition:self.stopPosition];
}

- (void) setButtonPosition:(CGPoint) p
{
    CGPoint newPosition = CGPointMake(p.x - self.frame.size.width/2.0f, p.y - self.frame.size.height/2.0f);
    self.frame = CGRectMake(newPosition.x, newPosition.y, self.frame.size.width, self.frame.size.height);
}

@end
