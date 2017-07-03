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
    IC_GOOGLE_LOGIN_REQUEST,
    IC_GET_ALL_INCUBEES,
    IC_GET_ALL_LIKED_INCUBEES,
    IC_GET_ALL_CUSTOMER_INCUBEES,
    IC_GET_CUSTOMER_DETAILES,
    IC_GET_INCUBEE_REVIEW,
    IC_GOOGLE_LOGIN,
    IC_GOOGLE_SIGNUP,
    IC_LIKE_PROJECT,
    IC_ADD_CUSTOMER_PROJECT,
    IC_GET_ALL_CHAT,
    IC_GET_FOUNDER_CHAT_ALL,
    IC_SEND_CHAT_MSG,
    IC_SUBMIT_REVIEW,
    IC_EDIT_REVIEW,
    IC_DELETE_REVIEW,
    IC_INVITE_FOUNDER,
    IC_ADD_ADHOC_INCUBEE,
    IC_GET_ALL_ADHOC_INCUBEE
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
@property (nonatomic,strong)NSString *requestMethod;
@property (nonatomic,assign)BOOL isTokenRequired;
@property (nonatomic,strong)ICRequestStatus *requestStatus;
@property (nonatomic,strong)id respondingController;
@property (nonatomic,assign)SEL selector;
@property (nonatomic,strong)NSData *responseRecivedData;
@property (nonatomic,strong)id parsedResponse;
@property (nonatomic,strong)NSError *error;
@property (nonatomic,strong)NSMutableDictionary *optionalData;

@end
