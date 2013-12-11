//
//  MTPacket.h
//  LectureApp
//
//  Created by Satu Peltola on 09/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const MTPacketKeyData;
extern NSString * const MTPacketKeyType;
extern NSString * const MTPacketKeyAction;

typedef enum { MTPacketTypeUnknown = -1 } MTPacketType;
typedef enum { MTPacketActionUnknown = -1 } MTPacketAction;

@interface MTPacket : NSObject

@property (strong, nonatomic) id data;
@property (assign, nonatomic) MTPacketType type;
@property (assign, nonatomic) MTPacketAction action;

#pragma mark -
#pragma mark Initialization
- (id)initWithData:(id)data;

@end
