//
//  HostConnectionManager.m
//  LectureApp
//
//  Created by Satu Peltola on 10/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "HostConnectionManager.h"
#import "MTPacket.h"
#import "VisualizationViewController.h"

@interface HostConnectionManager ()  <NSNetServiceDelegate, NSNetServiceBrowserDelegate, GCDAsyncSocketDelegate>


@property (strong, nonatomic) NSNetService *service;

@property (strong, nonatomic) GCDAsyncSocket *listening_socket;



//Now instead of one variable we have an array of sockets.
@property (strong, nonatomic) NSMutableArray *sockets;


@end


@implementation HostConnectionManager



static HostConnectionManager *sharedhostconnectionmanager = nil;


+ (void)initialize {
    
    sharedhostconnectionmanager = [[HostConnectionManager alloc] init];
    
}

+ (HostConnectionManager *)sharedhostconnectionmanager
{
    return sharedhostconnectionmanager;
}


- (id)init{
    
    self=[super init];
    return self;
    
}

-(void)start{
    
    [self startBroadcast];
    
}


- (void)startBroadcast {
    
    // Initialize GCDAsyncSocket
    self.listening_socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // Start Listening for Incoming Connections
    NSError *error = nil;
    if ([self.listening_socket acceptOnPort:0 error:&error]) {
        // Initialize Service Notice: when name is not defined it uses the default of the computer
        self.service = [[NSNetService alloc] initWithDomain:@"local." type:@"_lectureApp._tcp." name:@"" port:[self.listening_socket localPort]];
        // Configure Service
        [self.service setDelegate:self];
        // Publish Service
        [self.service publish];
    } else {
        NSLog(@"Unable to create socket. Error %@ with user info %@.", error, [error userInfo]);
    }
}

- (void)netServiceDidPublish:(NSNetService *)service {
    NSLog(@"Bonjour Service Published: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
}

- (void)netService:(NSNetService *)service didNotPublish:(NSDictionary *)errorDict {
    NSLog(@"Failed to Publish Service: domain(%@) type(%@) name(%@) - %@", [service domain], [service type], [service name], errorDict);
}


- (void)socket:(GCDAsyncSocket *)socket didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    NSLog(@"Accepted New Socket from %@:%hu", [newSocket connectedHost], [newSocket connectedPort]);
    
    // Instead of replacing the listening socket we add it to the mutable array
    //[self setSocket:newSocket];
    [self.sockets addObject:newSocket];
    
    // Read Data from Socket
    [newSocket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
    
    //This is for sending a packet when connection is established
    // Create Packet
    //NSString *message = @"Our packet was sent! And it works! Awesome! "; //message
    //MTPacket *packet = [[MTPacket alloc] initWithData:message type:0 action:0];
    // Send Packet
    //[self sendPacket:packet];
}

- (void)socket:(GCDAsyncSocket *)socket didReadData:(NSData *)data withTag:(long)tag {
    [[self.visualisation status] setText:@"We have connection!"];
    
    if (tag == 0) {
        uint64_t bodyLength = [self parseHeader:data];
        [socket readDataToLength:bodyLength withTimeout:-1.0 tag:1];
    } else if (tag == 1) {
        [self parseBody:data];
        [socket readDataToLength:sizeof(uint64_t) withTimeout:-1 tag:0]; //Why is it 30?
    }
    
    
}


- (uint64_t)parseHeader:(NSData *)data {
    uint64_t headerLength = 0;
    memcpy(&headerLength, [data bytes], sizeof(uint64_t));
    return headerLength;
}


- (void)parseBody:(NSData *)data {
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    MTPacket *packet = [unarchiver decodeObjectForKey:@"packet"];
    [unarchiver finishDecoding];
    
    NSString *receivedString = packet.data;
    
    BOOL tooDificult;
    NSLog(@"Voted: %@", receivedString);
    if( [receivedString isEqualToString:@"YES"] ){
        tooDificult = YES;
    }else{
        tooDificult = NO;
    }
    
    
    [self.visualisation addSplash:tooDificult];

    //NSLog(@"Packet Type > %i", packet.type);
    //NSLog(@"Packet Action > %i", packet.action);
}



@end
