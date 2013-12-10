//
//  ConnectionController.m
//  LectureApp
//
//  Created by Satu Peltola on 09/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "ConnectionController.h"
#import "MTPacket.h"

@interface ConnectionController ()  <NSNetServiceDelegate, NSNetServiceBrowserDelegate, GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *socket;

//These are probably not needed:
//@property (strong, nonatomic) NSMutableArray *services;
//@property (strong, nonatomic) NSNetServiceBrowser *serviceBrowser;

@end



@implementation ConnectionController

static ConnectionController *sharedconnectioncontroller = nil;


+ (void)initialize {
    
    sharedconnectioncontroller = [[ConnectionController alloc] init];
    
}

+ (ConnectionController *)sharedConnectionController
{
    return sharedconnectioncontroller;
}

- (id)init{
    
    self=[super init];
    return self;

}


//When socket is selected in JoinHostViewController this method is called

- (void)socketWasSelected:(NSNetService *)service{
    [service setDelegate:self];
    [service resolveWithTimeout:30.0];

    }

- (void)netService:(NSNetService *)service didNotResolve:(NSDictionary *)errorDict {
    [service setDelegate:nil];
}

- (void)netServiceDidResolveAddress:(NSNetService *)service {
    // Connect With Service
    if ([self connectWithService:service]) {
        NSLog(@"Did Connect with Service: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
    } else {
        NSLog(@"Unable to Connect with Service: domain(%@) type(%@) name(%@) port(%i)", [service domain], [service type], [service name], (int)[service port]);
    }
}



- (BOOL)connectWithService:(NSNetService *)service {
    BOOL _isConnected = NO;
    // Copy Service Addresses
    NSArray *addresses = [[service addresses] mutableCopy];
    if (!self.socket || ![self.socket isConnected]) {
        // Initialize Socket
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        // Connect
        while (!_isConnected && [addresses count]) {
            NSData *address = [addresses objectAtIndex:0];
            NSError *error = nil;
            if ([self.socket connectToAddress:address error:&error]) {
                _isConnected = YES;
            } else if (error) {
                NSLog(@"Unable to connect to address. Error %@ with user info %@.", error, [error userInfo]);
            }
        }
    } else {
        _isConnected = [self.socket isConnected];
    }
    return _isConnected;
}

- (void)socket:(GCDAsyncSocket *)socket didConnectToHost:(NSString *)host port:(UInt16)port {
    NSLog(@"Socket Did Connect to Host: %@ Port: %hu", host, port);
    // Start Reading
    [socket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)error {
    NSLog(@"Socket Did Disconnect with Error %@ with User Info %@.", error, [error userInfo]);
    [socket setDelegate:nil];
    [self setSocket:nil];
}

- (void)socket:(GCDAsyncSocket *)socket didReadData:(NSData *)data withTag:(long)tag {
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
    NSLog(@"Packet Data > %@", packet.data);
    //NSLog(@"Packet Type > %i", packet.type);
    //NSLog(@"Packet Action > %i", packet.action);
}



//Called from VoteViewController when one of the buttons is pressed
-(void)sendVote:(BOOL)tooDifficult{

    MTPacket *packet = [[MTPacket alloc] initWithData:tooDifficult];
    // Send Packet
    [self sendPacket:packet];

}




//Sending packet
- (void)sendPacket:(MTPacket *)packet {
    
    // Encode Packet Data
    NSMutableData *packetData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:packetData];
    [archiver encodeObject:packet forKey:@"packet"];
    [archiver finishEncoding];
    // Initialize Buffer
    NSMutableData *buffer = [[NSMutableData alloc] init];
    // Fill Buffer
    uint64_t headerLength = [packetData length];
    [buffer appendBytes:&headerLength length:sizeof(uint64_t)];
    [buffer appendBytes:[packetData bytes] length:[packetData length]];
    // Write Buffer
    [self.socket writeData:buffer withTimeout:-1.0 tag:0];
}



@end
