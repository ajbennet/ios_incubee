//
//  ICUserAccountManager.m
//  Incubee
//
//  Created by Rithesh Rao on 16/07/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICUserAccountManager.h"
#import "ICAppManager.h"
#import "ICAppManager+Networking.h"

@implementation ICUserAccountManager

static ICUserAccountManager *sharedUserAccountManagerInstance = nil;

+(ICUserAccountManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedUserAccountManagerInstance = [[self alloc] init];
        
    });
    
    return sharedUserAccountManagerInstance;
}
- (id)init {
    
    if (self = [super init])
    {
        
    }
    
    return self;
}

#pragma mark - GIDSignInDelegate -

// The sign-in flow has finished and was successful if |error| is |nil|.
- (void)signIn:(GIDSignIn *)signIn
didSignInForUser:(GIDGoogleUser *)user
     withError:(NSError *)error{
    
    if(error==nil)
    {
    
        NSLog(@"Logged in Succesfully : %@",user);
        
    }
    
    NSLog(@"%@ : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));

}

// Finished disconnecting |user| from the app successfully if |error| is |nil|.
- (void)signIn:(GIDSignIn *)signIn
didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error{

        NSLog(@"%@ : %@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));

}

@end
