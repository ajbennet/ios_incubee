//
//  IncubeeImage+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "IncubeeImage+CoreDataProperties.h"

@implementation IncubeeImage (CoreDataProperties)

+ (NSFetchRequest<IncubeeImage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"IncubeeImage"];
}

@dynamic imageUrl;
@dynamic incubeeId;
@dynamic incubee;

@end
