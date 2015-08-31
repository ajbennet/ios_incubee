//
//  ICOperationManager.m
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICAppManager.h"

@implementation ICAppManager

static ICAppManager *sharedAppManagerInstance = nil;

+(ICAppManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedAppManagerInstance = [[self alloc] init];
        
    });
    
    return sharedAppManagerInstance;
}
- (id)init {
    
    if (self = [super init])
    {
        
    }
    
    return self;
}

#pragma mark - KVO Delegates
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"status"])
    {
        ICRequest *pRequest = ((__bridge ICRequest*)context);
        
        NSLog(@"%@ : %d",NSStringFromSelector(_cmd),pRequest.requestStatus.status);
        
        switch (pRequest.requestStatus.status)
        {
            case REQUEST_ON_DATAPARSING:
            {
                [self performDataParsingOperation:pRequest];
            }
                break;
            case REQUEST_ON_DATASAVING:
            {
                [self performDataSavingOperation:pRequest];
            }
                break;
            case REQUEST_FINISHED:
            {
                SEL aSelector = (pRequest.selector);

                if([pRequest.respondingController respondsToSelector:aSelector])
                {
                    [pRequest.respondingController performSelectorOnMainThread:aSelector withObject:pRequest waitUntilDone:YES];
                }
                
                [pRequest.requestStatus removeObserver:self forKeyPath:@"status"];
                
            }
                break;
                
            default:
                break;
        }
    }
    
}


-(void)performDataParsingOperation:(ICRequest*)inRequest{
    
    NSLog(@"%@ : ",NSStringFromSelector(_cmd));
    
    ICJSONParsingOperations *operation = [[ICJSONParsingOperations alloc] initWithRequest:inRequest];
    
    [[ICOperationManager sharedInstance].dataParsingOperationQueue addOperation:operation];
    
}

-(void)performDataSavingOperation:(ICRequest*)inRequest{

    NSLog(@"%@ : ",NSStringFromSelector(_cmd));
    
    if(inRequest.error)
    {
        inRequest.requestStatus.status = REQUEST_FINISHED;
        
    }
    else
    {
        ICDataSavingOperations *dataSave = [[ICDataSavingOperations alloc] initWithRequest:inRequest];
        
        [[ICOperationManager sharedInstance].dataSavingOperationQueue addOperation:dataSave];
    }
    
}




@end

