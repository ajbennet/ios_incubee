//
//  PPRequest.m
//  PaparazziPass
//
//  Created by Rithesh Rao on 23/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICRequest.h"


@implementation ICRequestStatus

@end

@implementation ICRequest

-(id)init{
    
    self = [super init];
    
    if(self!=nil)
    {
        _reqDataDict = [[NSMutableDictionary alloc] init];
        
//        [_reqDataDict setObject:@"json" forKey:@"output"];
        
        _requestStatus = [[ICRequestStatus alloc] init];
        
        _requestStatus.status = REQUEST_INITIALIZED;
        
        _error = nil;
    }
    
    return self;
}


@end
