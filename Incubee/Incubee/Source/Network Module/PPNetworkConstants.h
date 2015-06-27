//
//  PPNetworkConstants.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 23/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#ifdef SERVER_PRODUCTION
    #define SERVER_HOST @"central.paparazzipass.com"
    #define SERVER_LOGIN_URL  @"http://central.paparazzipass.com:2050/?"

#elif SERVER_QA_INTERNAL
    #define SERVER_HOST @"10.1.25.50"
    #define SERVER_LOGIN_URL @"http://10.1.25.50:2050/?"

#elif SERVER_QA_EXTERNAL
    #define SERVER_HOST @"bengalore.dynalias.net"
    #define SERVER_LOGIN_URL @"http://dev.paparazzipass.com:2050/?"

#endif

#define HELLO "${SITEID}"