//
//  PPJSONParsingOperations.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 29/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ICRequest.h"

@interface ICJSONParsingOperations : NSOperation

@property(nonatomic,retain)ICRequest *request;

-(id)initWithRequest:(ICRequest*)inRequest;

@end
