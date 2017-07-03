//
//  User+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "User+CoreDataProperties.h"

@implementation User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"User"];
}

@dynamic email;
@dynamic founderCompanyId;
@dynamic imageURL;
@dynamic name;
@dynamic token;
@dynamic tokenExpDate;
@dynamic userId;
@dynamic userLoginMode;

@end
