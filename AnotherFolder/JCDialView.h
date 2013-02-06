//
//  JCDialView.h
//  AnotherFolder
//
//  Created by Jon Como on 2/4/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCDialView : UIView

@property float rotation, friction;

@property (nonatomic, strong) void (^turnBlock)(float rotation);
@property (nonatomic, strong) void (^selectedDigit)(u_int number);
@property (nonatomic, strong) void (^changedDirection)(BOOL clockwise);

@property u_int currentDigit;

-(void)dialWithNumberOfDigits:(u_int)numberOfDigits;

@end