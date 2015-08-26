//
//  PPRequest.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 23/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    IC_LOGIN_REQUEST,
    IC_GET_ALL_PROJECTS,
    IC_GOOGLE_LOGIN,
    IC_GOOGLE_SIGNUP,
    IC_LIKE_PROJECT,
    IC_ADD_CUSTOMER_PROJECT,
    IC_GET_ALL_CHAT
} REQUESTID;

typedef enum // Naming Conventions of the Enum's to be decided
{
    REQUEST_INITIALIZED,
    REQUEST_WAITING_ON_NETWORK,
    REQUEST_WAITING_ON_IMPLICIT_LOGIN,
	REQUEST_ON_NETWORKING,
    REQUEST_ON_DATAPARSING,
    REQUEST_ON_DATAPROCESSING,
    REQUEST_ON_DATASAVING,
    REQUEST_FINISHED,
} REQUESTSTATUS;


@interface ICRequestStatus : NSObject

@property(nonatomic,assign)REQUESTSTATUS status;

@end

@interface ICRequest : NSObject

@property (nonatomic,strong)NSURL *requestingURL;
@property (nonatomic,strong)NSMutableDictionary *reqDataDict;
@property (nonatomic,assign)REQUESTID requestId;
@property (nonatomic,strong)ICRequestStatus *requestStatus;
@property (nonatomic,strong)id respondingController;
@property (nonatomic,strong)NSString *selectorString;
@property (nonatomic,strong)NSData *responseRecivedData;
@property (nonatomic,strong)id parsedResponse;
@property (nonatomic,strong)NSError *error;
@property (nonatomic,strong)NSMutableDictionary *optionalData;

@end
