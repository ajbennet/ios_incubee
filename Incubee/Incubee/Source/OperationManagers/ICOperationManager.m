//
//  PPOperationManager.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 22/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICOperationManager.h"

@implementation ICOperationManager

static ICOperationManager *sharedOperationManagerInstance = nil;

+(ICOperationManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedOperationManagerInstance = [[self alloc] init];
        
    });
    
    return sharedOperationManagerInstance;
}


- (id)init {
    
    if (self = [super init])
    {
        _networkOperationQueue = [[NSOperationQueue alloc] init];
        
        [_networkOperationQueue setName:@"Network Operations Queue"];
        
        [_networkOperationQueue setMaxConcurrentOperationCount:5];        
        
        _dataParsingOperationQueue = [[NSOperationQueue alloc] init];
        
        [_dataParsingOperationQueue setName:@"Data Parsing Operations Queue"];
        
        [_dataParsingOperationQueue setMaxConcurrentOperationCount:5];
        
        _dataSavingOperationQueue = [[NSOperationQueue alloc] init];
        
        [_dataSavingOperationQueue setName:@"Data Parsing Operations Queue"];
        
        [_dataSavingOperationQueue setMaxConcurrentOperationCount:5];

    }
    return self;
}
@end
