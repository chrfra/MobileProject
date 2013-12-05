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
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    _splashes = [NSMutableArray array];
    
    //Create and store 10 splashes
    for(int i = 0; i < 10; i++)
    {
        
        //Randomly assign x and y coordinate for the splash so that it is entirely on the screen
        int x = arc4random() % (int) (self.view.frame.size.width);
        int y = arc4random() % (int) (self.view.frame.size.height);
        
        //Create one splash
        UIView *splash = [[Splash alloc] initWithFrame: CGRectMake ( x, y, kSplashInitialWidth, kSplashInitialWidth)];
        
        //Add splash to array of splashes
        [_splashes addObject:splash];
    }

    //Display all splases on screen
    for (Splash *splash in _splashes) {
        [self.view addSubview:splash];
    }
    NSLog(@"Rendering splashes ");
    
    //Start fading Splashes
    [self fade];
    //Start growing Splashes
    [self grow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 Animations
 */

#define kFadeDuration 5   //How long fading splash will take
#define kResizeDuration 5 //How long resizing splash will take
#define kGrowFactor 3     //How much splash should grow by
#define kShrinkFactor 3   //How much splash should shrink by

//Fades out all splashes over time
- (void)fade{
    for (Splash *splash in _splashes) {
        //Fade animation
        [UIView animateWithDuration:kFadeDuration
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             splash.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                         }];
    }

}

//Grows all splashes
- (void)grow {
    for (Splash *splash in _splashes) {
        CGAffineTransform transform = CGAffineTransformScale(splash.transform, kGrowFactor, kGrowFactor);
        [UIView animateWithDuration:kResizeDuration animations:^{
            splash.transform = transform;
        }];
    }
}


@end
