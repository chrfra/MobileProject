//
//  HostConnectionManager.h
//  LectureApp
//
//  Created by Satu Peltola on 10/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostConnectionManager : NSObject

+ (HostConnectionManager *) sharedhostconnectionmanager;

- (void)start;

@end
