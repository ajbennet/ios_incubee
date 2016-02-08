//
//  ICConstants.h
//  Incubee
//
//  Created by Rithesh Rao on 31/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#pragma mark - Notification Keys -

#define CHAT_VIEW_REFRESH @"Chat_view_Refresh"


typedef enum : NSUInteger {
    CHAT_VIEW_CUSTOMER_TO_FOUNDER,
    CHAT_VIEW_FOUNDER_TO_CUSTOMER
} CHAT_VIEW_MODE;

typedef enum : NSUInteger {
    USER_LOGIN_MODE_GUEST,
    USER_LOGIN_MODE_FOUNDER,
    USER_LOGIN_MODE_CUSTOMER,
    USER_LOGIN_MODE_INVESTOR
} USER_LOGIN_MODE;


#pragma mark - Notifications -

#define USER_AS_FOUNDER_NOTIFICATION @"USER_AS_FOUNDER_NOTIFICATION"

#pragma mark - ALERTVIEW TAGS -

#define ALERTTAG_INVITE_EMAIL 300

#pragma mark - STRING CONST -

#define INVITE @"Invite"

#pragma mark - DICTIONARY STRING KEY -

#define REVIEW_TITLE @"REVIEW_TITLE"
#define REVIEW_DESC @"REVIEW_DESC"
#define REVIEW_INCUBEE_ID @"REVIEW_INCUBEE_ID"
#define REVIEW_RATING @"REVIEW_RATING"
#define REVIEW_MEETING @"REVIEW_MEETING"
#define REVIEW_STATUS @"REVIEW_STATUS"

#define ADHOC_INCUBEE_TITLE @"ADHOC_INCUBEE_TITLE"
#define ADHOC_INCUBEE_EMAIL @"ADHOC_INCUBEE_EMAIL"
#define ADHOC_INCUBEE_MEETING @"ADHOC_INCUBEE_MEETING"
#define ADHOC_INCUBEE_STATUS @"ADHOC_INCUBEE_STATUS"
#define ADHOC_INCUBEE_RATING @"ADHOC_INCUBEE_RATING"
#define ADHOC_INCUBEE_DESC @"ADHOC_INCUBEE_DESC"




