//
//  AFLock.m
//  AnotherFolder
//
//  Created by Jon Como on 2/5/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import "AFLock.h"

@interface AFLock ()
{
    NSMutableArray *workingCombination;
    u_int digitsEntered;
}

@end

@implementation AFLock

+(id)lockWithCombination:(NSArray *)combo
{
    return [[AFLock alloc] initWithCombination:combo];
}

-(id)init
{
    if (self = [self initWithCombination:@[@0, @0, @0]]) {
        //Init
        
    }
    
    return self;
}

-(id)initWithCombination:(NSArray *)combo
{
    if (self = [super init]) {
        //Init
        _combination = [NSMutableArray arrayWithArray:combo];
        workingCombination = [NSMutableArray arrayWithArray:combo];
        digitsEntered = 0;
    }
    
    return self;
}

-(void)setCombination:(NSArray *)combination
{
    self.combination = [NSMutableArray arrayWithArray:combination];
    workingCombination = [NSMutableArray arrayWithArray:combination];
}

-(void)enterDigit:(u_int)digit
{
    NSNumber *number = @(digit);
    
    digitsEntered ++;
    
    if ([workingCombination[0] isEqual:number]) {
        [workingCombination removeObjectAtIndex:0];
    }
    
    if (self.progress) self.progress(self.combination.count - digitsEntered);
    
    if (workingCombination.count == 0) {
        //Got all the way through
        workingCombination = [NSMutableArray arrayWithArray:self.combination];
        if (self.attemptOutcome) self.attemptOutcome(YES);
    }else if (digitsEntered == self.combination.count)
    {
        if (self.attemptOutcome) self.attemptOutcome(NO);
    }
}

-(void)resetLock
{
    workingCombination = [NSMutableArray arrayWithArray:self.combination];
    digitsEntered = 0;
}

-(void)tryLastDigit:(u_int)lastDigit
{
    NSNumber *number = @(lastDigit);
    
    if ([workingCombination[0] isEqual:number] && workingCombination.count == 1) {
        [workingCombination removeObjectAtIndex:0];
        if (self.progress) self.progress(self.combination.count - workingCombination.count);
        workingCombination = [NSMutableArray arrayWithArray:self.combination];
        if (self.attemptOutcome) self.attemptOutcome(YES);
        NSLog(@"UNLOCKED!");
    }

}

@end