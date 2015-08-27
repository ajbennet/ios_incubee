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

-(void)getAllProject:(ICRequest**)inRequest notifyTo:(id)aViewController atSelector:(SEL)inSelector;

-(void)getAllProject:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName;

-(void)sendGoogleLogin:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName;

-(void)sendGoogleSignUp:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName;

-(void)likeProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(NSString*)funName;

-(void)addCustomerProject:(ICRequest**)inRequest withIncubeeId:(NSString*)inCubeeId notifyTo:(id)aViewController forSelector:(NSString*)funName;


#pragma mark - Chat -
-(void)getAllChat:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName;


@end
