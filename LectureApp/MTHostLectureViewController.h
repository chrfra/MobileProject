//
//  MTHostLectureViewController.h
//  LectureApp
//
//  Created by Satu Peltola on 09/12/13.
//  Copyright (c) 2013 Satu Peltola. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
@class GCDAsyncSocket;
@protocol MTHostGameViewControllerDelegate;
@interface MTHostGameViewController : UIViewController
@property (weak, nonatomic) id delegate;
@end
@protocol MTHostGameViewControllerDelegate
- (void)controller:(MTHostGameViewController *)controller didHostGameOnSocket:(GCDAsyncSocket *)socket;
- (void)controllerDidCancelHosting:(MTHostGameViewController *)controller;
@end