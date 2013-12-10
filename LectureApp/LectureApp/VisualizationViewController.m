//
//  VisualizationViewController.m
//  LectureApp
//
//  Created by Christian Fransson on 04/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//
//Buttons

#import "VisualizationViewController.h"
#import "Splash.h"
#import "HostConnectionManager.h"

@interface VisualizationViewController ()

@end

@implementation VisualizationViewController

#define kSplashMaxWidth 150 //Maximum width & height that a splash can assume, make into global static variable
#define kSplashInitialWidth 50 //Maximum width & height that a splash can assume, make into global static variable

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
	//Give a reference to this view to the host connection manager so that when the HostConnectionManager receives a vote, it can call addSplash
    [[HostConnectionManager sharedhostconnectionmanager] setVisualisation:self];
}

-(void)viewWillAppear:(BOOL)animated
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Adds a splash to the visualization
//@parameter tooDifficult whether the received button pressed indicated the lecture being too difficult
-(void)addSplash:(BOOL)tooDifficult
{
    /* Testing code generating sample votes
    If there are no splashes, create 10 sample splashes (just for testing)*/
    
    //why to repeat this?
    /*if(_splashes == nil){
        _splashes = [NSMutableArray array];
    }*/
        /*
        //Create and store 10 splashes
        for(int i = 0; i < 10; i++)
        {
            int x = (arc4random() % ( (int)(self.view.frame.size.width - (kSplashMaxWidth/2)) ) );
            int y = (arc4random() % ( (int)(self.view.frame.size.height - (kSplashMaxWidth)) ) ) + (kSplashMaxWidth/2);
            
            BOOL difficult;
            
            if(i<5){
                difficult =YES;
            }else{
                difficult =NO;
            }
            //Create one splash
            UIView *splash = [[Splash alloc] initWithFrame: CGRectMake ( x, y, kSplashInitialWidth, kSplashInitialWidth) tooDifficult:difficult];
            
            //Add splash to array of splashes
            [_splashes addObject:splash];
        }
    }*/
    
    /*Real code*/
    if(_splashes == nil){
        _splashes = [NSMutableArray array];
    }
    int x = (arc4random() % ( (int)(self.view.frame.size.width - (kSplashMaxWidth/2)) ) );
    int y = (arc4random() % ( (int)(self.view.frame.size.height - (kSplashMaxWidth)) ) ) + (kSplashMaxWidth/2);

    //Create one splash
    Splash *splash = [[Splash alloc] initWithFrame: CGRectMake ( x, y, kSplashInitialWidth, kSplashInitialWidth) tooDifficult:tooDifficult];
            
    //Add splash to array of splashes
    [_splashes addObject:splash];
    
    //Display all splases on screen
    [self.view addSubview:splash];
    
    //Start fading Splashes
    [splash fade];
    //Start growing Splashes
    [splash grow];
}



@end
