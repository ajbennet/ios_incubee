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
#import "ICNetworkConstant.h"

#import "User.h"

@implementation ICAppManager (Networking)

#pragma mark - App Manager Utility -

-(void)addRequestActivityObserver:(ICRequest*)inRequest{
    
    ICRequestStatus *status = inRequest.requestStatus;
    
    [status addObserver:self forKeyPath:@"status" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:(__bridge void *)inRequest];
    
}

-(void)addReqComplitionListner:(ICRequest*)aRequest forController:(id)aController atSelector:(SEL)inMethod{
    
    aRequest.respondingController = aController;
    
    aRequest.selector = inMethod;
}

-(void)sendRequestObject:(ICRequest*)inRequest{
    
    ICNetworkOperation *operation = [[ICNetworkOperation alloc] initWithRequest:inRequest];
    
    inRequest.requestStatus.status = REQUEST_WAITING_ON_NETWORK;
    
    [[ICOperationManager sharedInstance].networkOperationQueue addOperation:operation];
    
}

#pragma mark - Network Call -
-(void)getAllIncubees:(ICRequest**)inRequest notifyTo:(id)aViewController atSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_INCUBEES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];

    req.isTokenRequired = NO;
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGetAllCompanyURL]]];
    
    [self sendRequestObject:req];

    
}

-(void)sendGoogleLogin:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GOOGLE_LOGIN_REQUEST;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGoogleLoginURL]]];
    
    User *user = [[ICDataManager sharedInstance] getUser];

    [req.reqDataDict setValue:user.name forKey:@"name"];
    
    [req.reqDataDict setValue:user.userId forKey:@"id"];
    
    [req.reqDataDict setValue:user.email forKey:@"email"];

    req.isTokenRequired = YES;
    
    [self sendRequestObject:req];

}

-(void)sendGoogleSignUp:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GOOGLE_SIGNUP;
    
    req.requestMethod = ICRequestMethodPost;

    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGoogleSignUpURL]]];
    
    User *user = [[ICDataManager sharedInstance] getUser];
    
    [req.reqDataDict setValue:user.name forKey:@"name"];
    
    [req.reqDataDict setValue:user.userId forKey:@"id"];
    
    [req.reqDataDict setValue:user.email forKey:@"email"];
    
    req.isTokenRequired = YES;
    
    [self sendRequestObject:req];
}

-(void)likeProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_LIKE_PROJECT;
    
    req.requestMethod = ICRequestMethodPost;

    req.isTokenRequired = YES;

    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:inCubeeId,@"incubee_id",nil];
    
    [req setOptionalData:(NSMutableDictionary*)d];
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kLikeIncubeeURL(inCubeeId,[[ICDataManager sharedInstance] getUserId])]]];
        
    [self sendRequestObject:req];

}

-(void)addCustomerProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_ADD_CUSTOMER_PROJECT;
    
    req.requestMethod = ICRequestMethodPost;
    
    req.isTokenRequired = YES;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:inCubeeId,@"incubee_id",nil];
    
    [req setOptionalData:(NSMutableDictionary*)d];
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kAddCustomer(inCubeeId,[[ICDataManager sharedInstance] getUserId])]]];
    
    [self sendRequestObject:req];
    
}


-(void)getAllLikedIncubee:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_LIKED_INCUBEES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    req.isTokenRequired = NO;
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kAllLikedIncubees([[ICDataManager sharedInstance] getUserId])]]];
    
    [self sendRequestObject:req];

}

-(void)getAllCustomerIncubee:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_CUSTOMER_INCUBEES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    req.isTokenRequired = NO;
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kAllCustomerIncubees([[ICDataManager sharedInstance] getFounderId])]]];
    
    [self sendRequestObject:req];
    
    
}

-(void)getCustomerDetails:(NSString*)inCustomerId withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_CUSTOMER_DETAILES;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    req.isTokenRequired = NO;
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kCustomerDetails(inCustomerId)]]];
    
    [self sendRequestObject:req];
    
}

#pragma mark - Investor -

-(void)getReview:(NSString*)inIncubeeId withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_INCUBEE_REVIEW;
    
    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    req.isTokenRequired = NO;
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGetIncubeeReview(inIncubeeId)]]];
    
    [self sendRequestObject:req];
    
}


-(void)submitReview:(NSDictionary*)reviewDic withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_SUBMIT_REVIEW;
    
    req.isTokenRequired = YES;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kSubmitReview([[ICDataManager sharedInstance] getUserId])]]];
    
    
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    
    [d setValue:[reviewDic valueForKey:REVIEW_TITLE] forKey:@"title"];
    [d setValue:[reviewDic valueForKey:REVIEW_DESC] forKey:@"description"];
    [d setValue:[reviewDic valueForKey:REVIEW_INCUBEE_ID] forKey:@"incubee_id"];
    [d setValue:[reviewDic valueForKey:REVIEW_RATING] forKey:@"rating"];
    [d setValue:[reviewDic valueForKey:REVIEW_MEETING] forKey:@"meeting"];
    [d setValue:[reviewDic valueForKey:REVIEW_STATUS] forKey:@"status"];
    
    
    [req setReqDataDict:(NSMutableDictionary*)d];
    
    [self sendRequestObject:req];

    
    
    
}

-(void)inviteFounder:(NSString*)inEmail withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_INVITE_FOUNDER;
    
    req.isTokenRequired = YES;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kInviteFounder(inEmail,[[ICDataManager sharedInstance] getUserId])]]];
    
    [self sendRequestObject:req];
}


-(void)addAdhocInvubee:(NSDictionary*)adhocInvubeeDic withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_ADD_ADHOC_INCUBEE;
    
    req.isTokenRequired = YES;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kAddAdhocIncubee([[ICDataManager sharedInstance] getUserId])]]];
    
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    
    [d setValue:[adhocInvubeeDic valueForKey:ADHOC_INCUBEE_NAME] forKey:@"name"];
    [d setValue:[adhocInvubeeDic valueForKey:ADHOC_INCUBEE_EMAIL] forKey:@"email_id"];
    
    [req setReqDataDict:(NSMutableDictionary*)d];
    
    [self sendRequestObject:req];

}

-(void)getAllAdhocIncubees:(ICRequest**)inRequest notifyTo:(id)aViewController atSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_ADHOC_INCUBEE;
    
    req.isTokenRequired = YES;

    req.requestMethod = ICRequestMethodGet;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGetAllAdhocIncubee]]];
    
    [self sendRequestObject:req];

}



#pragma mark - Chat -
-(void)getAllChat:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{

    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_GET_ALL_CHAT;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGetAllChatMsg([[ICDataManager sharedInstance] getUserId])]]];
    
    [self sendRequestObject:req];
    
}

-(void)getFoundersChat:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    NSLog(@"IC_GET_FOUNDER_CHAT_ALL : %@",[[ICDataManager sharedInstance] getFounderId]);
    
    req.requestId = IC_GET_FOUNDER_CHAT_ALL;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,kGetAllFounderChatMsg([[ICDataManager sharedInstance] getFounderId])]]];
    
    [self sendRequestObject:req];

}


-(void)sendMsg:(ICRequest**)inRequest textMsg:(NSString*)inMsg to:(NSString*)inTo type:(NSString*)inType isToFounder:(BOOL)inToFounder notifyTo:(id)aViewController forSelector:(SEL)inSelector{
    
    ICRequest *req = [[ICRequest alloc] init];
    
    req.requestId = IC_SEND_CHAT_MSG;
    
    req.isTokenRequired = YES;
    
    req.requestMethod = ICRequestMethodPost;
    
    [self addRequestActivityObserver:req];
    
    [self addReqComplitionListner:req forController:aViewController atSelector:inSelector];
    
    [req setRequestingURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.apiBaseUrl,ksendChatMsg( inToFounder == NO ? [[ICDataManager sharedInstance] getFounderId] : [[ICDataManager sharedInstance] getUserId])]]];    

    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    
    [d setValue:inMsg forKey:@"body"];
    
    [d setValue:( inToFounder == NO ? [[ICDataManager sharedInstance] getFounderId] : [[ICDataManager sharedInstance] getUserId]) forKey:@"eid"];
    
    [d setValue:[[ICDataManager sharedInstance] getUserName] forKey:@"name"];
    
    [d setValue:inTo forKey:@"to"];
    
    [d setValue:@"200" forKey:@"longitude"];
    
    [d setValue:@"100" forKey:@"latitude"];
    
    [d setValue:inType forKey:@"type"];
    
    [req setReqDataDict:(NSMutableDictionary*)d];

    [self sendRequestObject:req];

}


@end
