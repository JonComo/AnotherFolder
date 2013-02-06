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
    
    if ([workingCombination[0] isEqual:number]) {
        [workingCombination removeObjectAtIndex:0];
        NSLog(@"Correct: %@", workingCombination);
    }else{
        workingCombination = [NSMutableArray arrayWithArray:self.combination];
        NSLog(@"Failed: %@", workingCombination);
    }
    
    if (workingCombination.count == 0) {
        //Got all the way through
        NSLog(@"UNLOCKED!");
        workingCombination = [NSMutableArray arrayWithArray:self.combination];
    }
}

@end