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
        self.color = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];
    }else{
        self.color = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.5];
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 // Drawing code
 
 CGRect splash = CGRectInset(self.bounds, 2, 2);
 
 // Create an oval shape to draw.
 UIBezierPath* aPath = [UIBezierPath bezierPathWithOvalInRect:splash];;
 
 // Set the render colors
 [[UIColor blackColor] setStroke];
 [self.color setFill];
 
 // Fill the path before stroking it so that the fill
 // color does not obscure the stroked line.
 [aPath fill];

}


@end
