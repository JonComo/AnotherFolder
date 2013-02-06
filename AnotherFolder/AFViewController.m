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
    
    lock = [AFLock lockWithCombination:@[@5, @3, @8]];
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
