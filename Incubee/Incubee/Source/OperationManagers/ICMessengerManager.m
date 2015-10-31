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
#import "ICConstants.h"

@interface ICMessengerManager()

@property(nonatomic,strong)NSTimer *syncTimer;

@property(nonatomic,strong)NSTimer *yetToUpdateTimer;

@property(nonatomic,assign)BOOL yetUpdatedUI;

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
        _syncTimer = [NSTimer  scheduledTimerWithTimeInterval:30 target:self selector:@selector(syncChat) userInfo:nil repeats:YES];
    }
    
    return self;
}

#pragma mark - Sync -

-(void)syncChat{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    [[ICAppManager sharedInstance] getAllChat:nil notifyTo:self forSelector:@selector(allChatResponse:)];
    
    if([[ICDataManager sharedInstance] isFounder])
    {
        [[ICAppManager sharedInstance] getAllCustomerIncubee:nil notifyTo:self forSelector:@selector(customerSyncIncubee:)];

    }

}

#pragma mark - Update UI -

-(void)handleUIUpdated
{
    if(_yetUpdatedUI == NO)
    {
        _yetUpdatedUI = YES;
        
        _yetToUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateUI) userInfo:nil repeats:NO];
    }
    
}

-(void)updateUI{

    if([_yetToUpdateTimer isValid])
    {
        [_yetToUpdateTimer invalidate];
        
        _yetToUpdateTimer = nil;
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CHAT_VIEW_REFRESH object:nil];
    
    _yetUpdatedUI = NO;

}

#pragma mark  - Network Notification -
-(void)allChatResponse:(ICRequest*)inRequest{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
   
    if([[ICDataManager sharedInstance] isFounder] == NO)
    {
        [self handleUIUpdated];
    }
    
}

-(void)customerSyncIncubee:(ICRequest*)inRequest{

    [[ICAppManager sharedInstance] getFoundersChat:nil notifyTo:self forSelector:@selector(allFounderChatResponse:)];
    
    NSArray *allCustomer = [[ICDataManager sharedInstance] getAllCustomer];
    
    for(uint i=0;i<allCustomer.count;i++)
    {
        Customer *aCustomer =  [allCustomer objectAtIndex:i];
        
        if(i+1 == allCustomer.count)
        {
            [[ICAppManager sharedInstance] getCustomerDetails:aCustomer.userId withRequest:nil notifyTo:self forSelector:nil];
        }
        else
        {
           [[ICAppManager sharedInstance] getCustomerDetails:aCustomer.userId withRequest:nil notifyTo:self forSelector:@selector(allCustomerDetailRetrived:)];
        }
    }

}

-(void)allFounderChatResponse:(ICRequest*)inRequest{
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    NSArray *allCustomer = [[ICDataManager sharedInstance] getAllCustomer];

    if(allCustomer.count>0)
    {
        [self handleUIUpdated];
    }

}

-(void)allCustomerDetailRetrived:(ICRequest*)inRequest{

    [self handleUIUpdated];
}

@end


