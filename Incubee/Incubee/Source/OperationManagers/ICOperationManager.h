//
//  PPOperationManager.h
//  PaparazziPass
//
//  Created by Rithesh Rao on 22/05/14.
//  Copyright (c) 2014 Deja View Concepts. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ICOperationManager : NSObject

@property (nonatomic, strong) NSOperationQueue *networkOperationQueue;

@property (nonatomic, strong) NSOperationQueue *dataParsingOperationQueue;

@property (nonatomic, strong) NSOperationQueue *dataSavingOperationQueue;

+(ICOperationManager*)sharedInstance;

@end
