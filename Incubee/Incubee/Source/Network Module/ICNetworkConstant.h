//
//  ICNetworkConstant.h
//  Incubee
//
//  Created by Rithesh Rao on 29/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//
//
//#ifndef Incubee_ICNetworkConstant_h
//#define Incubee_ICNetworkConstant_h

#pragma mark - SERVER -
#ifdef DEBUG

#define SERVER_REST_PROTOCOL        @"http://"

#define SERVER_HOST                 @"www.incub.ee"

#define SERVER_API_VERSION @"v1.0"

#elif RELEASE

#define SERVER_REST_PROTOCOL        @"http://"

#define SERVER_HOST                 @"www.incub.ee"

#define SERVER_API_VERSION @"v1.0"

#endif

#pragma mark - REST URL -

#define kGetAllCompanyURL  [NSString stringWithFormat:@"%@%@/rest/%@/all",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION]

#define kGoogleLoginURL  [NSString stringWithFormat:@"%@%@/rest/%@/login",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION]

#define kGoogleSignUpURL  [NSString stringWithFormat:@"%@%@/rest/%@/signup",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION]

#define kLikeIncubeeURL(incubeeId,userId) [NSString stringWithFormat:@"%@%@/rest/%@/like/%@?uid=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,incubeeId,userId]

#define kAddCustomer(incubeeId,userId) [NSString stringWithFormat:@"%@%@/rest/%@/customer/%@?uid=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,incubeeId,userId]

#define kAllLikedIncubees(userId) [NSString stringWithFormat:@"%@%@/rest/%@/like?id=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,userId]

#define kAllCustomerIncubees(userId) [NSString stringWithFormat:@"%@%@/rest/%@/customer?id=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,userId]

#define kCustomerDetails(customerId) [NSString stringWithFormat:@"%@%@/rest/%@/customer/details?id=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,customerId]

#define kGetAllChatMsg(userId) [NSString stringWithFormat:@"%@%@/rest/%@/msg/all?eid=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,userId]

#define kGetAllFounderChatMsg(userId) [NSString stringWithFormat:@"%@%@/rest/%@/msg/all?eid=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,userId]

#define ksendChatMsg(userId) [NSString stringWithFormat:@"%@%@/rest/%@/msg?eid=%@",SERVER_REST_PROTOCOL,SERVER_HOST,SERVER_API_VERSION,userId]

#pragma mark - Request Method -

#define ICRequestMethodGet @"GET"
#define ICRequestMethodPost @"POST"
#define ICRequestMethodPut @"PUT"
#define ICRequestMethodDelete @"DELETE"
