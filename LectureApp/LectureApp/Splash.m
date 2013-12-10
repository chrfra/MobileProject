//
//  Splash.m
//  LectureApp
//
//  Created by Christian Fransson on 04/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "Splash.h"

@implementation Splash

- (id)initWithFrame:(CGRect)frame tooDifficult:(BOOL)tooDifficult
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp:tooDifficult];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [self setUp:YES];
    }
    return self;
}

- (void)setUp:(BOOL)tooDifficult {
    self.backgroundColor = [UIColor clearColor];
    if(tooDifficult){
        self.color = [UIColor colorWithRed:255 green:255 blue:0 alpha:1];
    }else{
        self.color = [UIColor colorWithRed:0 green:255 blue:255 alpha:1];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 // Drawing code
 
 CGRect splash = CGRectInset(self.bounds, 2, 2);
 
 // Create an oval shape to draw.
 UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:splash];
 
 // Set the render colors
 //[[UIColor blackColor] setStroke];
 [self.color setFill];
 
 // Fill the path before stroking it so that the fill
 // color does not obscure the stroked line.
 [aPath fill];
}


/*
 Animations
 */

#define kFadeDuration 30   //How long fading splash will take
#define kResizeDuration 30//How long resizing splash will take
#define kGrowFactor 6     //How much splash should grow by
#define kShrinkFactor 3   //How much splash should shrink by

//Fades out all splashes over time
- (void)fade{
        //Fade animation
        [UIView animateWithDuration:kFadeDuration
                              delay: 0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             self.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                         }];
}

//Grows all splashes
- (void)grow {
        CGAffineTransform transform = CGAffineTransformScale(self.transform, kGrowFactor, kGrowFactor);
        [UIView animateWithDuration:kResizeDuration animations:^{
            self.transform = transform;
        }];
}



@end
