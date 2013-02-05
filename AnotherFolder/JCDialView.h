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

-(void)dialWithNumberOfDigits:(u_int)numberOfDigits;

@end
