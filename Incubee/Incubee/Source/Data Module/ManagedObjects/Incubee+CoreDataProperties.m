//
//  Incubee+CoreDataProperties.m
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Incubee+CoreDataProperties.h"

@implementation Incubee (CoreDataProperties)

+ (NSFetchRequest<Incubee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Incubee"];
}

@dynamic companyDescription;
@dynamic companyName;
@dynamic companyUrl;
@dynamic contactEmail;
@dynamic field;
@dynamic founder;
@dynamic funding;
@dynamic highConcept;
@dynamic incubeeId;
@dynamic location;
@dynamic logoUrl;
@dynamic projectFollowing;
@dynamic projectStatus;
@dynamic twitterUrl;
@dynamic video;
@dynamic videoUrl;
@dynamic incubeeImage;

@end
