//
//  HostingViewController.h
//  LectureApp
//
//  Created by Satu Peltola on 03/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisualizationViewController.h"

@interface HostingViewController : UIViewController

@property (strong,nonatomic) VisualizationViewController * visView;

@property (weak, nonatomic) IBOutlet UILabel *lectureIdLabel;

@end
