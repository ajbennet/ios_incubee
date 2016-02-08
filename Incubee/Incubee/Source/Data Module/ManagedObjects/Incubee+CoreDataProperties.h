//
//  Incubee+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 08/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Incubee.h"

NS_ASSUME_NONNULL_BEGIN

@interface Incubee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *companyDescription;
@property (nullable, nonatomic, retain) NSString *companyName;
@property (nullable, nonatomic, retain) NSString *companyUrl;
@property (nullable, nonatomic, retain) NSString *contactEmail;
@property (nullable, nonatomic, retain) NSString *field;
@property (nullable, nonatomic, retain) NSString *founder;
@property (nullable, nonatomic, retain) NSNumber *funding;
@property (nullable, nonatomic, retain) NSString *highConcept;
@property (nullable, nonatomic, retain) NSString *incubeeId;
@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *logoUrl;
@property (nullable, nonatomic, retain) NSNumber *projectFollowing;
@property (nullable, nonatomic, retain) NSString *projectStatus;
@property (nullable, nonatomic, retain) NSString *twitterUrl;
@property (nullable, nonatomic, retain) NSString *video;
@property (nullable, nonatomic, retain) NSString *videoUrl;
@property (nullable, nonatomic, retain) NSSet<IncubeeImage *> *incubeeImage;

@end

@interface Incubee (CoreDataGeneratedAccessors)

- (void)addIncubeeImageObject:(IncubeeImage *)value;
- (void)removeIncubeeImageObject:(IncubeeImage *)value;
- (void)addIncubeeImage:(NSSet<IncubeeImage *> *)values;
- (void)removeIncubeeImage:(NSSet<IncubeeImage *> *)values;

@end

NS_ASSUME_NONNULL_END
