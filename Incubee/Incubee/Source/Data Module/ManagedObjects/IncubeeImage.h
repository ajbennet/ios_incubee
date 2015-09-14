//
//  IncubeeImage.h
//  Incubee
//
//  Created by Rithesh Rao on 14/09/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Incubee;

@interface IncubeeImage : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * incubeeId;
@property (nonatomic, retain) Incubee *incubee;

@end
