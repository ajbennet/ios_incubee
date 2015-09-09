//
//  ICConstants.h
//  Incubee
//
//  Created by Rithesh Rao on 31/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

//#ifndef Incubee_ICConstants_h
//#define Incubee_ICConstants_h
//
//
//#endif

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#pragma mark - Notification Keys -

#define CHAT_VIEW_REFRESH @"Chat_view_Refresh"


typedef enum : NSUInteger {
    CHAT_VIEW_CUSTOMER_TO_FOUNDER,
    CHAT_VIEW_FOUNDER_TO_CUSTOMER
} CHAT_VIEW_MODE;