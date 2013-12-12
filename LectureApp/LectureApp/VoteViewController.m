//
//  VoteViewController.m
//  LectureApp
//
//  Created by Satu Peltola on 09/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "VoteViewController.h"
#import "ConnectionController.h"

@interface VoteViewController ()

@end

@implementation VoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tooEasy:(UIButton *)sender {
    [[ConnectionController sharedConnectionController] sendVote:NO];
    self.tooEasy.userInteractionEnabled = NO;
    self.tooEasy.alpha = 0.5;
    [self performSelector: @selector (enableButton:) withObject:sender afterDelay:60.0F];

}


- (IBAction)tooDifficult:(UIButton *)sender {
    [[ConnectionController sharedConnectionController] sendVote:YES];
    self.tooDifficult.userInteractionEnabled = NO;
    self.tooDifficult.alpha = 0.5;

    [self performSelector: @selector (enableButton:) withObject:sender afterDelay:60.0F];
}

- (void)viewWillDisappear:(BOOL)animated{
    //[super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [[ConnectionController sharedConnectionController] stop];
        
    }
}

- (int)enableButton:(UIButton *)sender{
    sender.userInteractionEnabled = YES;
    sender.alpha = 1;
    return 1;
}



@end
