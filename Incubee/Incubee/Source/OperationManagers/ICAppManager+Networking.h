//
//  ICOperationManager+Networking.h
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICAppManager.h"
#import "ICRequest.h"

@interface ICAppManager (Networking)

#pragma mark - Incubees -
-(void)getAllIncubees:(ICRequest**)inRequest notifyTo:(id)aViewController atSelector:(SEL)inSelector;

-(void)sendGoogleLogin:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)sendGoogleSignUp:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)likeProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)addCustomerProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)getAllLikedIncubee:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)getAllCustomerIncubee:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)getCustomerDetails:(NSString*)inCustomerId withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

#pragma mark - Investor -

-(void)getReview:(NSString*)inIncubeeId withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)submitReview:(NSDictionary*)reviewDic withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)inviteFounder:(NSString*)inEmail withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)addAdhocInvubee:(NSDictionary*)adhocInvubeeDic withRequest:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;



#pragma mark - Chat -

-(void)getAllChat:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)getFoundersChat:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(SEL)inSelector;

-(void)sendMsg:(ICRequest**)inRequest textMsg:(NSString*)inMsg to:(NSString*)inTo type:(NSString*)inType isToFounder:(BOOL)inToFounder notifyTo:(id)aViewController forSelector:(SEL)inSelector;

@end
