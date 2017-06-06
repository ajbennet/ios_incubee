//
//  Messages+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Messages+CoreDataProperties.h"

@implementation Messages (CoreDataProperties)

+ (NSFetchRequest<Messages *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Messages"];
}

@dynamic body;
@dynamic dir;
@dynamic eid;
@dynamic lattitude;
@dynamic longitude;
@dynamic media;
@dynamic mid;
@dynamic name;
@dynamic status;
@dynamic stime;
@dynamic time;
@dynamic to;
@dynamic type;

@end
