//
//  Customer+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Customer+CoreDataProperties.h"

@implementation Customer (CoreDataProperties)

+ (NSFetchRequest<Customer *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Customer"];
}

@dynamic email;
@dynamic imageUrl;
@dynamic userId;
@dynamic userName;

@end
