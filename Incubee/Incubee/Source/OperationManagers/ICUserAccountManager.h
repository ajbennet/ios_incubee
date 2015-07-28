//
//  ICUserAccountManager.h
//  Incubee
//
//  Created by Rithesh Rao on 16/07/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Google/SignIn.h>
#import "ICRequest.h"

@interface ICUserAccountManager : NSObject <GIDSignInDelegate>

+(ICUserAccountManager*)sharedInstance;

@property(nonatomic,assign)int userLoginBadgeCount;

-(void)updateLoginBadgeCount;

#pragma mark - Network Notifications -
- (void)loginResponse:(ICRequest*)inRequest;
- (void)googleSignup:(ICRequest*)inRequest;

@end
