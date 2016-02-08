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
            case IC_GET_FOUNDER_CHAT_ALL:
            {
            
                NSArray *array = [inRequest.parsedResponse objectForKey:@"messages"];
                
                [self saveChatArray:array];
                
            }
                break;
            case IC_GET_ALL_LIKED_INCUBEES:
            {
                NSArray *array = [inRequest.parsedResponse objectForKey:@"incubeeList"];
                
                NSLog(@"incubeeLikedList : %@",array);
                
                [self saveLikedArray:array];

            }
                break;
            
            case IC_GET_ALL_CUSTOMER_INCUBEES:
            {
                NSArray *array = [inRequest.parsedResponse objectForKey:@"incubeeList"];
                
                NSLog(@"CustomerList : %@",array);
                
                [self saveCustomerArray:array];
                
            }
                break;
                
            case IC_GET_CUSTOMER_DETAILES:
            {
                NSArray *array = [inRequest.parsedResponse objectForKey:@"customerList"];
                
                NSLog(@"IC_GET_CUSTOMER_DETAILES : %@",array);
                // This should be always 1
                if(array.count == 1)
                {
                    [self updateCustomerDetails:(NSDictionary*)[array objectAtIndex:0]];
                }

            }
                break;
            case IC_GET_INCUBEE_REVIEW:
            {
                NSArray *array = [inRequest.parsedResponse objectForKey:@"reviews"];
                
                [self saveReviewArray:array];

            }
                break;
            case IC_GET_ALL_ADHOC_INCUBEE:
            {
            
                NSArray *adhocInvubeeListArray = [inRequest.parsedResponse objectForKey:@"incubeeList"];
                
                NSLog(@"adhocInvubeeListArray : %@",adhocInvubeeListArray);
                
                [self saveAdHocIncubees:adhocInvubeeListArray];

            }
                break;
            default:
                break;
        }
        
        inRequest.requestStatus.status = REQUEST_FINISHED;
    }
    
}


@end
