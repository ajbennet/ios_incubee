//
//  PPDataSavingOperations.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 18/06/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ICRequest.h"

@interface ICDataSavingOperations : NSOperation
{
    ICRequest *request;
}

-(id)initWithRequest:(ICRequest*)aRequest;

@end
