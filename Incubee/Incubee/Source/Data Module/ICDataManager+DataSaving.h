//
//  PPDataManager+DataSaving.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 31/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import "ICDataManager.h"

#import "ICRequest.h"

@interface ICDataManager (DataSaving)

-(void)saveResponse:(ICRequest*)inRequest;

@end
