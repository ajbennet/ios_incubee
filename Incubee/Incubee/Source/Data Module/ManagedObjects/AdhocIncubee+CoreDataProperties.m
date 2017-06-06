//
//  AdhocIncubee+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "AdhocIncubee+CoreDataProperties.h"

@implementation AdhocIncubee (CoreDataProperties)

+ (NSFetchRequest<AdhocIncubee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AdhocIncubee"];
}

@dynamic adhocIncubeeId;
@dynamic adhocIncubeeName;
@dynamic createdById;
@dynamic emailId;

@end
