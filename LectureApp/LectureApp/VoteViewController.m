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
    NSLog(@"TooEasy!");
    
    [[ConnectionController sharedConnectionController] tooEasy];
    
}

@end
