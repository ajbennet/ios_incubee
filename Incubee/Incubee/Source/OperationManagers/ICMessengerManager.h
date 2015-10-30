//
//  ICMessengerManager.h
//  Incubee
//
//  Created by Rithesh Rao on 26/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICRequest.h"

@interface ICMessengerManager : NSObject

+(ICMessengerManager*)sharedInstance;

#pragma mark - Sync -
-(void)syncChat;

#pragma mark  - Network Notification - 
-(void)allChatResponse:(ICRequest*)inRequest;
-(void)allCustomerDetailRetrived:(ICRequest*)inRequest;
@end
