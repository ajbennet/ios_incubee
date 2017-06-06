//
//  Review+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Review+CoreDataProperties.h"

@implementation Review (CoreDataProperties)

+ (NSFetchRequest<Review *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Review"];
}

@dynamic date;
@dynamic dislikes;
@dynamic incubee_id;
@dynamic likes;
@dynamic meeting;
@dynamic rating;
@dynamic replies;
@dynamic reviewDescription;
@dynamic reviewTitle;
@dynamic status;
@dynamic user_id;
@dynamic views;
@dynamic review_id;

@end
