//
//  IncubeeImage+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 24/10/15.
//  Copyright © 2015 Incubee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "IncubeeImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface IncubeeImage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageUrl;
@property (nullable, nonatomic, retain) NSString *incubeeId;
@property (nullable, nonatomic, retain) Incubee *incubee;

@end

NS_ASSUME_NONNULL_END
