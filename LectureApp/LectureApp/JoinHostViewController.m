//
//  JoinHostViewController.m
//  LectureApp
//
//  Created by Satu Peltola on 03/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//


//This is Satu's test comment

#import "JoinHostViewController.h"
#import "MTPacket.h"
#import "ConnectionController.h"

@interface JoinHostViewController () <NSNetServiceDelegate, NSNetServiceBrowserDelegate, GCDAsyncSocketDelegate>
@property (strong, nonatomic) GCDAsyncSocket *socket;
@property (strong, nonatomic) NSMutableArray *services;
@property (strong, nonatomic) NSNetServiceBrowser *serviceBrowser;


@end

@implementation JoinHostViewController

static NSString *ServiceCell = @"ServiceCell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startBrowsing];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.services ? 1 : 0;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.services count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceCell];
    if (!cell) {
        // Initialize Table View Cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ServiceCell];
    }
    // Fetch Service
    NSNetService *service = [self.services objectAtIndex:[indexPath row]];
    // Configure Cell
    [cell.textLabel setText:[service name]];
    return cell;
    
    
    
    
}



- (void)startBrowsing {
    if (self.services) {
        [self.services removeAllObjects];
    } else {
        self.services = [[NSMutableArray alloc] init];
    }
    // Initialize Service Browser
    self.serviceBrowser = [[NSNetServiceBrowser alloc] init];
    // Configure Service Browser
    [self.serviceBrowser setDelegate:self];
    [self.serviceBrowser searchForServicesOfType:@"_lectureApp._tcp." inDomain:@"local."];
}


- (void)netServiceBrowser:(NSNetServiceBrowser *)serviceBrowser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
    // Update Services
    [self.services addObject:service];
    if(!moreComing) {
        // Sort Services
        [self.services sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
        // Update Table View
        [self.tableView reloadData];
    }
}

- (void)netServiceBrowserDidStopSearch:(NSNetServiceBrowser *)serviceBrowser {
    [self stopBrowsing];
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aBrowser didNotSearch:(NSDictionary *)userInfo {
    [self stopBrowsing];
}


//Called when back button is pressed
- (void)viewWillDisappear:(BOOL)animated{
    //[super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController || self.isBeingDismissed) {
             [self stopBrowsing];
        [[ConnectionController sharedConnectionController] stop];
        
    }
}


- (void)stopBrowsing {
    if (self.serviceBrowser) {
        [self.serviceBrowser stop];
        [self.serviceBrowser setDelegate:nil];
        [self setServiceBrowser:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Fetch Service
    NSNetService *service = [self.services objectAtIndex:[indexPath row]];
    // Resolve Service
    
    //These were edited away in reconstruction!
    //[service setDelegate:self];
    //[service resolveWithTimeout:30.0];
    
    //Sending the service to ConnectionController
    [[ConnectionController sharedConnectionController] socketWasSelected:service];
    
    [self performSegueWithIdentifier:@"tovoteview" sender:self];
    
    //
    
}




@end
