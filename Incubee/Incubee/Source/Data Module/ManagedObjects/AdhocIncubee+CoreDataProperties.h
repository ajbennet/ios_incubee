//
//  AdhocIncubee+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "AdhocIncubee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AdhocIncubee (CoreDataProperties)

+ (NSFetchRequest<AdhocIncubee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *adhocIncubeeId;
@property (nullable, nonatomic, copy) NSString *adhocIncubeeName;
@property (nullable, nonatomic, copy) NSString *createdById;
@property (nullable, nonatomic, copy) NSString *emailId;

@end

NS_ASSUME_NONNULL_END
