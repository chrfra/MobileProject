//
//  Lecture.m
//  LectureApp
//
//  Created by Satu Peltola on 28/11/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "Lecture.h"

@implementation Lecture

- (id)init{
    
    _points = 0;
    _ID = @"00000";
    return self;
}


// return the point count and reset the point counter
- (int)getPoints{
    
    int i = _points;
        _points = 0;
    return i;
    
}

// if boolean is true, add one to the points, if boolean is wrong remove one point. 
- (void)VoteWithBoolean:(Boolean *)boolean{
    
    if(boolean){
        _points++;
    }
    else{
        _points--;
    }
    
}

@end
