//
//  ICOperationManager.h
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICOperationManager.h"
#import "ICRequest.h"
#import "ICNetworkOperation.h"
#import "ICJSONParsingOperations.h"
#import "ICDataSavingOperations.h"
#import "ICDataManager+DataSaving.h"

@interface ICAppManager : NSObject

@property(nonatomic,retain)NSString* apiBaseUrl;
+(ICAppManager*)sharedInstance;

@end
