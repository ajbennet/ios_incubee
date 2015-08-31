//
//  ICMessengerManager.m
//  Incubee
//
//  Created by Rithesh Rao on 26/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICMessengerManager.h"
#import "ICAppManager.h"
#import "ICAppManager+Networking.h"

@interface ICMessengerManager()

@property(nonatomic,strong)NSTimer *syncTimer;


-(void)syncChat;

@end

@implementation ICMessengerManager

static ICMessengerManager *sharedMessengerInstance = nil;

+(ICMessengerManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedMessengerInstance = [[self alloc] init];
        
    });
    
    return sharedMessengerInstance;
}
- (id)init {
    
    if (self = [super init])
    {
        _syncTimer = [NSTimer  scheduledTimerWithTimeInterval:60 target:self selector:@selector(syncChat) userInfo:nil repeats:YES];
    }
    
    return self;
}

#pragma mark - Sync -

-(void)syncChat{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [[ICAppManager sharedInstance] getAllChat:nil notifyTo:self forSelector:@selector(allChatResponse:)];

}

#pragma mark  - Network Notification -
-(void)allChatResponse:(ICRequest*)inRequest{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));

    
}

@end


