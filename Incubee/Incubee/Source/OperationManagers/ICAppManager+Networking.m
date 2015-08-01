//
//  ICOperationManager+Networking.m
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICAppManager+Networking.h"
#import "ICOperationManager.h"
#import "ICNetworkOperation.h"

#import "User.h"

@implementation ICAppManager (Networking)

#pragma mark - App Manager Utility -

-(void)addRequestActivityObserver:(ICRequest*)inRequest{
    
    ICRequestStatus *status = inRequest.requestStatus;
    
    [status addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void *)inRequest];
    
}

-(void)addReqComplitionListner:(ICRequest*)aRequest forController:(id)aController atMethod:(NSString*)aMethodName{
    
    aRequest.respondingController = aController;
    
    aRequest.selectorString = aMethodName;
    
}

-(void)sendRequestObject:(ICRequest*)inRequest{
    
    ICNetworkOperation *operation = [[ICNetworkOperation alloc] initWithRequest:inRequest];
    
    inRequest.requestStatus.status = REQUEST_WAITING_ON_NETWORK;
    
    [[ICOperationManager sharedInstance].networkOperationQueue addOperation:operation];
    
}

#pragma mark - Network Call -
-(void)getAllProject:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_PROJECTS;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atMethod:funName];
    
    [req setRequestingURL:[NSURL URLWithString:@"http://www.incub.ee/rest/all"]];
    
    [self sendRequestObject:req];

}

-(void)sendGoogleLogin:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_LOGIN_REQUEST;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atMethod:funName];
    
    [req setRequestingURL:[NSURL URLWithString:@"http://www.incub.ee/rest/login"]];
    
    User *user = [[ICDataManager sharedInstance] getUser];

    [req.reqDataDict setValue:user.name forKey:@"name"];
    
    [req.reqDataDict setValue:user.userId forKey:@"id"];
    
    [req.reqDataDict setValue:user.email forKey:@"email"];

    [req.reqDataDict setValue:user.token forKey:@"token"];
    
    [self sendRequestObject:req];

}

-(void)sendGoogleSignUp:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GOOGLE_SIGNUP;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atMethod:funName];
    
    [req setRequestingURL:[NSURL URLWithString:@"http://www.incub.ee/rest/signup"]];
    
    User *user = [[ICDataManager sharedInstance] getUser];
    
    [req.reqDataDict setValue:user.name forKey:@"name"];
    
    [req.reqDataDict setValue:user.userId forKey:@"id"];
    
    [req.reqDataDict setValue:user.email forKey:@"email"];
    
    [req.reqDataDict setValue:user.token forKey:@"token"];
    
    //    [req.reqDataDict setValue:@"https://lh4.googleusercontent.com/-CL6coBFm9VE/AAAAAAAAAAI/AAAAAAAAHCk/ngCxGax3Tcc/s96-c/photo.jpg" forKey:@"image_url"];
    
    [self sendRequestObject:req];
}

-(void)likeProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(NSString*)funName{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_LIKE_PROJECT;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atMethod:funName];
    
    NSString *urlString = [NSString stringWithFormat:@"http://www.incub.ee/rest/like/%@?uid=%@",inCubeeId,[[ICDataManager sharedInstance] getUserId]];
    
    NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:inCubeeId,@"incubee_id",nil];
    
    [req setOptionalData:(NSMutableDictionary*)d];
    
    [req setRequestingURL:[NSURL URLWithString:urlString]];
        
    [self sendRequestObject:req];

}

@end
