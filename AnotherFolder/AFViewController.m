//
//  AFViewController.m
//  AnotherFolder
//
//  Created by Jon Como on 2/4/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import "AFViewController.h"
#import "JCDialView.h"
#import "AFLock.h"

@interface AFViewController ()
{
    __weak IBOutlet JCDialView *dial;
    AFLock *lock;
    
    
    __weak IBOutlet UIView *indicator;
    
    __weak IBOutlet UIView *l1;
    __weak IBOutlet UIView *l2;
    __weak IBOutlet UIView *l3;
}

@end

@implementation AFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    lock = [AFLock lockWithCombination:@[@5, @3, @5]];
    
    [dial setSelectedDigit:^(u_int digit) {
        [lock tryLastDigit:digit];
        
        indicator.backgroundColor = [UIColor whiteColor];
        [UIView animateWithDuration:0.3 animations:^{
            indicator.backgroundColor = [UIColor blackColor];
        }];
    }];
    
    [dial setChangedDirection:^(BOOL clockwise) {
        [lock enterDigit:dial.currentDigit];
    }];
    
    __weak UIView *indicator1 = l1;
    __weak UIView *indicator2 = l2;
    __weak UIView *indicator3 = l3;
    
    [lock setProgress:^(u_int progress) {
        switch (progress) {
            case 0:
                indicator1.backgroundColor = [UIColor orangeColor];
                break;
            case 1:
                indicator2.backgroundColor = [UIColor orangeColor];
                break;
            case 2:
                indicator3.backgroundColor = [UIColor orangeColor];
                break;
                
            default:
                break;
        }
    }];
    
    [lock setAttemptOutcome:^(BOOL unlocked) {
        if (unlocked) {
            [UIView animateWithDuration:0.3 animations:^{
                indicator1.backgroundColor = [UIColor greenColor];
                indicator2.backgroundColor = [UIColor greenColor];
                indicator3.backgroundColor = [UIColor greenColor];
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                indicator1.backgroundColor = [UIColor redColor];
                indicator2.backgroundColor = [UIColor redColor];
                indicator3.backgroundColor = [UIColor redColor];
            }];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [dial dialWithNumberOfDigits:10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
