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

-(void)getAllProject:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_PROJECTS;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atMethod:funName];
    
    [req setRequestingURL:[NSURL URLWithString:@"http://incubee.elasticbeanstalk.com/rest/all"]];
    
    [self sendRequestObject:req];

}


@end
