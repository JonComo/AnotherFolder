//
//  JCDialView.h
//  AnotherFolder
//
//  Created by Jon Como on 2/4/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^turnBlock)(float rotation);
typedef void (^selectedDigit)(u_int number);
typedef void (^changedDirection)(BOOL clockwise);

@interface JCDialView : UIView

@property float rotation, friction;

@property (nonatomic, strong) turnBlock onDialTurn;
@property (nonatomic, strong) selectedDigit onSelectedDigit;
@property (nonatomic, strong) changedDirection onDirectionChange;

@property u_int currentDigit;

-(void)dialWithNumberOfDigits:(u_int)numberOfDigits;

@end