//
//  ICOperationManager+Networking.h
//  Incubee
//
//  Created by Rithesh Rao on 27/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICAppManager.h"
#import "ICRequest.h"

@interface ICAppManager (Networking)

-(void)getAllProject:(ICRequest**)inRequest notifyTo:(id)aViewController forSelector:(NSString*)funName;


@end
