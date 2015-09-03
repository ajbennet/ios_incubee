//
//  PPDataManager+DataSaving.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 31/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICDataManager+DataSaving.h"

@implementation ICDataManager (DataSaving)

-(void)saveResponse:(ICRequest*)inRequest{
    
    // Sucessfull Responses will take forwarded to saving into Database.
    
    NSLog(@"Data Saving Operartions : %@ main thread", ([NSThread isMainThread] ?@"Is On" : @" NOT On"));
    
    @synchronized(self)
    {
        switch (inRequest.requestId) {
                
            case IC_GET_ALL_INCUBEES:
            {
                [self saveProjectList:inRequest.parsedResponse];
                
            }
                break;
                
            case IC_LIKE_PROJECT:
            {
                NSString *str = [inRequest.optionalData valueForKey:@"incubee_id"];
                
                [self followProject:str];
            }
                break;
            case IC_GET_ALL_CHAT:
            {
            
                NSArray *array = [inRequest.parsedResponse objectForKey:@"messages"];
                
                [self saveChatArray:array];
                
            }
                break;
            case IC_GET_ALL_LIKED_INCUBEES:
            {
                NSArray *array = [inRequest.parsedResponse objectForKey:@"incubeeList"];
                
                NSLog(@"incubeeList : %@",array);
                
                [self saveLikedArray:array];

            }
                break;
            
            case IC_GET_ALL_CUSTOMER_INCUBEES:
            {
                NSArray *array = [inRequest.parsedResponse objectForKey:@"incubeeList"];
                
                NSLog(@"incubeeList : %@",array);
                
                [self saveCustomerArray:array];
                
            }
                break;
                
            default:
                break;
        }
        
        inRequest.requestStatus.status = REQUEST_FINISHED;
    }
    
}


@end
