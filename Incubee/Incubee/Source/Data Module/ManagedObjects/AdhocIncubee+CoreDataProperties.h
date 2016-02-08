//
//  AdhocIncubee+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 08/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AdhocIncubee.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdhocIncubee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *adhocIncubeeId;
@property (nullable, nonatomic, retain) NSString *emailId;
@property (nullable, nonatomic, retain) NSString *adhocIncubeeName;
@property (nullable, nonatomic, retain) NSString *createdById;

@end

NS_ASSUME_NONNULL_END
