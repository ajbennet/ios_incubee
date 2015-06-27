//
//  PPNetworkOperation.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 23/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICRequest.h"

@interface ICNetworkOperation : NSOperation <NSURLConnectionDelegate>
{
    NSMutableData *receivedData;
    
}
@property(nonatomic,strong)ICRequest *request;

-(id)initWithRequest:(ICRequest*)inRequest;

@end
