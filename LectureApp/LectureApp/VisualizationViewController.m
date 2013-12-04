//
//  VisualizationViewController.m
//  LectureApp
//
//  Created by Christian Fransson on 04/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "VisualizationViewController.h"
#import "Splash.h"

@interface VisualizationViewController ()

@end

@implementation VisualizationViewController

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

-(void)viewWillAppear:(BOOL)animated
{
    //Create one splash
    UIView *splash = [[Splash alloc] initWithFrame: CGRectMake ( self.view.frame.size.width/2, self.view.frame.size.height/2, 150, 150)];
    //Show splash on screen
    [self.view addSubview:splash];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
