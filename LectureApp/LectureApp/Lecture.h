//
//  Lecture.h
//  LectureApp
//
//  Created by Satu Peltola on 28/11/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lecture : NSObject

@property int points;
@property NSString *ID;

- (id)init;
- (int)getPoints;
- (void)VoteWithBoolean:(Boolean *)boolean;


@end
