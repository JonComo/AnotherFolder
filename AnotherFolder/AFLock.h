//
//  AFLock.h
//  AnotherFolder
//
//  Created by Jon Como on 2/5/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFLock : NSObject

@property (nonatomic, strong) NSArray *combination;
@property (nonatomic, strong) void (^progress)(u_int progress);
@property (nonatomic, strong) void (^attemptOutcome)(BOOL unlocked);

+(id)lockWithCombination:(NSArray *)combo;
-(void)enterDigit:(u_int)digit;
-(void)tryLastDigit:(u_int)lastDigit;

@end