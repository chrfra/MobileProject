//
//  Splash.h
//  LectureApp
//
//  Created by Christian Fransson on 04/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Splash : UIView

- (id)initWithFrame:(CGRect)frame tooDifficult:(BOOL)tooDifficult;

@property (nonatomic, strong) UIColor *color;

@end
