//
//  JCDialView.m
//  AnotherFolder
//
//  Created by Jon Como on 2/4/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import "JCDialView.h"

#import <QuartzCore/QuartzCore.h>

@interface JCDialView ()
{
    float rotationVelocity;
    float lastAngle;
    float angleDifference;
    float lastDirection;
    
    NSTimer *rotateTimer;
    
    u_int digits;
}

@end

@implementation JCDialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return [self initWithFrame:CGRectZero];
}

-(void)setup
{
    _rotation = 0;
    _friction = 0.2;
    _currentDigit = 0;
    rotationVelocity = 0;
}

-(void)dialWithNumberOfDigits:(u_int)numberOfDigits
{
    for (UIView *subview in self.subviews)
    {
        [subview removeFromSuperview];
    }
    
    digits = numberOfDigits;
    float angleDivision = 360 / digits;
    float radius = self.frame.size.width/2 - 32;
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    for (u_int i = 0; i<numberOfDigits; i++) {
        //Add labels at angles
        float angleDegrees = angleDivision/2 + i * angleDivision - 90;
        CGPoint pushedPoint = [self pointFromPoint:center pushedBy:radius inDirection:angleDegrees];
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(pushedPoint.x - 10, pushedPoint.y - 10, 20, 20)];
        numberLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.text = [NSString stringWithFormat:@"%i", i];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.layer.transform = CATransform3DMakeRotation(angleDegrees * M_PI/180 + M_PI/2, 0, 0, 1);
        
        [self addSubview:numberLabel];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    rotationVelocity = 0;
    angleDifference = 0;
    [rotateTimer invalidate];
    rotateTimer = nil;
    
    CATransform3D transform = self.layer.transform;
    self.layer.transform = CATransform3DIdentity;
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    lastAngle = [self angleFromPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) toPoint:touchLocation];
    
    self.layer.transform = transform;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.layer.transform = CATransform3DIdentity;
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    float newAngle = [self angleFromPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) toPoint:touchLocation];
    
    angleDifference = (newAngle - lastAngle);
    
    if (ABS(angleDifference) < M_PI*1.9)
    {
        if (angleDifference > 0 && lastDirection < 0) {
            //Direction change
            if (self.onDirectionChange) self.onDirectionChange(YES);
        }else if(angleDifference < 0 && lastDirection > 0)
        {
            //Other dir
            if (self.onDirectionChange) self.onDirectionChange(NO);
        }
        lastDirection = angleDifference;
    }
    
    self.rotation += angleDifference;
    
    lastAngle = newAngle;
    
    self.rotation = [self constrainRotation:self.rotation];
    
    if (self.onDialTurn) self.onDialTurn(self.rotation * 180 / M_PI);
    
    [self findCurrentDialFromRotation:self.rotation];
    
    self.layer.transform = CATransform3DMakeRotation(self.rotation, 0, 0, 1);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (ABS(angleDifference) > 0.8) {
        angleDifference *= -1;
    }
    
    if (angleDifference > 0.2) {
        angleDifference = 0.2;
    }else if(angleDifference < -0.2)
    {
        angleDifference = -0.2;
    }
    
    rotationVelocity = 0;
    rotationVelocity += angleDifference;
    rotateTimer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(rotateLayer) userInfo:nil repeats:YES];
}

-(void)rotateLayer
{
    if (ABS(rotationVelocity) < 0.001) {
        rotationVelocity = 0;
        [rotateTimer invalidate];
        rotateTimer = nil;
    }
    
    self.rotation += rotationVelocity;
    
    rotationVelocity *= (1-self.friction);
    
    self.rotation = [self constrainRotation:self.rotation];
    
    self.layer.transform = CATransform3DMakeRotation(self.rotation, 0, 0, 1);
}

-(void)findCurrentDialFromRotation:(float)rotation
{
    u_int selectedNumber = (digits-1) - roundf((rotation * 180/M_PI)/360 * (digits-1));
    
    if (self.currentDigit != selectedNumber) {
        self.currentDigit = selectedNumber;
        if (self.onSelectedDigit) self.onSelectedDigit(self.currentDigit);
    }
}

-(float)constrainRotation:(float)rotation
{
    if (rotation<0) {
        rotation += M_PI * 2;
    }else if(rotation > M_PI * 2)
    {
        rotation -= M_PI * 2;
    }
    
    return rotation;
}

#pragma math

-(float)angleFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2
{
    float angle;
    
    float dx = point2.x - point1.x;
    float dy = point2.y - point1.y;
    
    angle = atan2f(dy, dx);
    
    if (angle<0) {
        angle += M_PI * 2;
    }
    
    return angle;
}

-(CGPoint)pointFromPoint:(CGPoint)point pushedBy:(float)pushAmount inDirection:(float)degrees
{
    float radians = degrees * M_PI/180.0;
    point.x += pushAmount * cosf(radians);
    point.y += pushAmount * sinf(radians);
    
    return point;
}

@end
