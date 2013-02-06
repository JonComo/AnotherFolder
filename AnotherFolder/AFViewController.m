//
//  AFViewController.m
//  AnotherFolder
//
//  Created by Jon Como on 2/4/13.
//  Copyright (c) 2013 Jon Como. All rights reserved.
//

#import "AFViewController.h"
#import "JCDialView.h"
#import <AVFoundation/AVFoundation.h>

@interface AFViewController ()
{
    __weak IBOutlet JCDialView *dial;
    NSArray *userCombo;
    AVAudioPlayer *audioPlayer;
}

@end

@implementation AFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/click.wav", [[NSBundle mainBundle] resourcePath]]];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    userCombo = @[@3, @1, @8];
    
    [dial setOnDialTurn:^(float rotation){
        
    }];
    
    [dial setOnSelectedDigit:^(u_int number){
        
    }];
    
    [dial setOnDirectionChange:^(BOOL clockwise){
        [audioPlayer stop];
        [audioPlayer play];
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
