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
                NSArray *array = NULL_TO_NIL([inRequest.parsedResponse objectForKey:@"messages"]);
                if (array != nil && array.count > 0){
                    [self saveChatArray:array];
                }
            }
                break;
            case IC_GET_ALL_LIKED_INCUBEES:
            {
                NSArray *array = NULL_TO_NIL([inRequest.parsedResponse objectForKey:@"incubeeList"]);
                if (array != nil && array.count > 0){
                    [self saveLikedArray:array];
                }
            }
                break;
            
            case IC_GET_ALL_CUSTOMER_INCUBEES:
            {
                NSArray *array = NULL_TO_NIL([inRequest.parsedResponse objectForKey:@"incubeeList"]);
                
                if (array != nil){
                [self saveCustomerArray:array];
                }
            }
                break;
                
            case IC_GET_CUSTOMER_DETAILES:
            {
                NSArray *array = NULL_TO_NIL([inRequest.parsedResponse objectForKey:@"customerList"]);
                
                // This should be always 1
                if(array != nil && array.count == 1)
                {
                    [self updateCustomerDetails:(NSDictionary*)[array objectAtIndex:0]];
                }

            }
                break;
            case IC_GET_INCUBEE_REVIEW:
            {
                NSArray *array = NULL_TO_NIL([inRequest.parsedResponse objectForKey:@"reviews"]);
                
                if(array != nil){
                [self saveReviewArray:array];
                }
            }
                break;
            case IC_GET_ALL_ADHOC_INCUBEE:
            {                
                NSArray *adhocInvubeeListArray = NULL_TO_NIL([inRequest.parsedResponse objectForKey:@"incubeeList"]);
                if(adhocInvubeeListArray != nil){
                    [self saveAdHocIncubees:adhocInvubeeListArray];
                }
            }
                break;
                
            case IC_DELETE_REVIEW:{
                
                NSString *reviewId = [inRequest.reqDataDict valueForKey:REVIEW_ID];
                
                if (reviewId){
                    [self deleteReview:reviewId];
                }
            }
                break;
            default:
                break;
        }
        
        inRequest.requestStatus.status = REQUEST_FINISHED;
    }
    
}


@end
