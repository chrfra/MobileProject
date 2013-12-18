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

- (void)viewWillDisappear:(BOOL)animated{
    //[super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
        [[HostConnectionManager sharedhostconnectionmanager] stop];
        
    }
}

@end

