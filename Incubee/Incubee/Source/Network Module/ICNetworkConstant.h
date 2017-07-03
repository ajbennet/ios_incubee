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

#define SERVER_API_VERSION @"v1.0"

#pragma mark - REST URL -

#define kGetAllCompanyURL  [NSString stringWithFormat:@"rest/%@/all",SERVER_API_VERSION]

#define kGoogleLoginURL  [NSString stringWithFormat:@"rest/%@/login",SERVER_API_VERSION]

#define kGoogleSignUpURL  [NSString stringWithFormat:@"rest/%@/signup",SERVER_API_VERSION]

#define kLikeIncubeeURL(incubeeId,userId) [NSString stringWithFormat:@"rest/%@/like/%@?uid=%@",SERVER_API_VERSION,incubeeId,userId]

#define kAddCustomer(incubeeId,userId) [NSString stringWithFormat:@"rest/%@/customer/%@?uid=%@",SERVER_API_VERSION,incubeeId,userId]

#define kAllLikedIncubees(userId) [NSString stringWithFormat:@"rest/%@/like?id=%@",SERVER_API_VERSION,userId]

#define kAllCustomerIncubees(userId) [NSString stringWithFormat:@"rest/%@/customer?id=%@",SERVER_API_VERSION,userId]

#define kCustomerDetails(customerId) [NSString stringWithFormat:@"rest/%@/customer/details?id=%@",SERVER_API_VERSION,customerId]

#define kGetAllChatMsg(userId) [NSString stringWithFormat:@"rest/%@/msg/all?eid=%@",SERVER_API_VERSION,userId]

#define kGetIncubeeReview(incubeeId) [NSString stringWithFormat:@"rest/%@/review/%@",SERVER_API_VERSION,incubeeId]

#define kSubmitReview(userId) [NSString stringWithFormat:@"rest/%@/review?uid=%@",SERVER_API_VERSION,userId]

#define kEditReview(userId,review_id) [NSString stringWithFormat:@"rest/%@/review?uid=%@&review_id=%@",SERVER_API_VERSION,userId,review_id]

#define kdeleteReview(userId,review_id) [NSString stringWithFormat:@"rest/%@/review?uid=%@&review_id=%@",SERVER_API_VERSION,userId,review_id]

#define kInviteFounder(emailId,userId) [NSString stringWithFormat:@"rest/%@/invite/%@?uid=%@",SERVER_API_VERSION,emailId,userId]

#define kGetAllFounderChatMsg(userId) [NSString stringWithFormat:@"rest/%@/msg/all?eid=%@",SERVER_API_VERSION,userId]

#define ksendChatMsg(userId) [NSString stringWithFormat:@"rest/%@/msg?eid=%@",SERVER_API_VERSION,userId]

#define kAddAdhocIncubee(userId) [NSString stringWithFormat:@"rest/%@/adhocincubee?uid=%@",SERVER_API_VERSION,userId]

#define kGetAllAdhocIncubee  [NSString stringWithFormat:@"rest/%@/adhocincubee",SERVER_API_VERSION]


#pragma mark - Request Method -

#define ICRequestMethodGet @"GET"
#define ICRequestMethodPost @"POST"
#define ICRequestMethodPut @"PUT"
#define ICRequestMethodDelete @"DELETE"
