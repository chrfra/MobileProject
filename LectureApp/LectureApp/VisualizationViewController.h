//
//  VisualizationViewController.h
//  LectureApp
//
//  Created by Christian Fransson on 04/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisualizationViewController : UIViewController

@property (strong,nonatomic) NSMutableArray *splashes;
@property (weak, nonatomic) IBOutlet UILabel *waitingLabel;

-(void)addSplash:(BOOL)tooDifficult;
- (void)fade;
- (void)grow;

@end
