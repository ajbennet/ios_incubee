//
//  AppDelegate.h
//  Incubee
//
//  Created by Rithesh Rao on 17/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//
#import <Google/SignIn.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

