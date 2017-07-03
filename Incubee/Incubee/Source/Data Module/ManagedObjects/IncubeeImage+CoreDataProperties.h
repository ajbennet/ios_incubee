//
//  IncubeeImage+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "IncubeeImage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface IncubeeImage (CoreDataProperties)

+ (NSFetchRequest<IncubeeImage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *incubeeId;
@property (nullable, nonatomic, retain) Incubee *incubee;

@end

NS_ASSUME_NONNULL_END
