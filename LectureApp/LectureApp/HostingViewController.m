//
//  HostingViewController.m
//  LectureApp
//
//  Created by Satu Peltola on 03/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import "HostingViewController.h"
#import "MTPacket.h"
#import "HostConnectionManager.h"

@interface HostingViewController ()  <NSNetServiceDelegate, GCDAsyncSocketDelegate>

@property (strong, nonatomic) NSNetService *service;
@property (strong, nonatomic) GCDAsyncSocket *socket;
@end




@implementation HostingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //Show lecture id (name of phone on network) in label
    [_lectureIdLabel setText:[[NSProcessInfo processInfo] hostName]];
}
- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Start Broadcast by calling start method for HostConnectionManager.
    //[self startBroadcast];
    [[HostConnectionManager sharedhostconnectionmanager] start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 This is old connection stuff, now moved to HostConnectionManager.
 
- (void)startBroadcast {
    // Initialize GCDAsyncSocket
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    // Start Listening for Incoming Connections
    NSError *error = nil;
    if ([self.socket acceptOnPort:0 error:&error]) {
        // Initialize Service Notice: when name is not defined it uses the default of the computer
        self.service = [[NSNetService alloc] initWithDomain:@"local." type:@"_lectureApp._tcp." name:@"" port:[self.socket localPort]];
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
    // Socket
    [self setSocket:newSocket];
    // Read Data from Socket
    [newSocket readDataToLength:sizeof(uint64_t) withTimeout:-1.0 tag:0];
    
    //This is for sending a packet when connection is established
    // Create Packet
    //NSString *message = @"Our packet was sent! And it works! Awesome! "; //message
    //MTPacket *packet = [[MTPacket alloc] initWithData:message type:0 action:0];
    // Send Packet
    //[self sendPacket:packet];
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)socket withError:(NSError *)error {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    if (self.socket == socket) {
        [self.socket setDelegate:nil];
        [self setSocket:nil];
    }
}

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
    NSLog(@"Packet Type > %i", packet.type);
    NSLog(@"Packet Action > %i", packet.action);
}

*/
@end

