//
//  Splash.m
//  LectureApp
//
//  Created by Christian Fransson on 04/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "Splash.h"

@implementation Splash

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self){
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor clearColor];
    self.color = [UIColor colorWithRed:0 green:255 blue:255 alpha:0.5];
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
