//
//  ConnectionController.h
//  LectureApp
//
//  Created by Satu Peltola on 09/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionController : NSObject

+ (ConnectionController *) sharedConnectionController;

- (void)socketWasSelected:(NSNetService *)service;

-(void)sendVote:(BOOL)tooDifficult;

-(void)stop;

@end
