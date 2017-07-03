//
//  Incubee+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Incubee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Incubee (CoreDataProperties)

+ (NSFetchRequest<Incubee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *companyDescription;
@property (nullable, nonatomic, copy) NSString *companyName;
@property (nullable, nonatomic, copy) NSString *companyUrl;
@property (nullable, nonatomic, copy) NSString *contactEmail;
@property (nullable, nonatomic, copy) NSString *field;
@property (nullable, nonatomic, copy) NSString *founder;
@property (nullable, nonatomic, copy) NSNumber *funding;
@property (nullable, nonatomic, copy) NSString *highConcept;
@property (nullable, nonatomic, copy) NSString *incubeeId;
@property (nullable, nonatomic, copy) NSString *location;
@property (nullable, nonatomic, copy) NSString *logoUrl;
@property (nullable, nonatomic, copy) NSNumber *projectFollowing;
@property (nullable, nonatomic, copy) NSString *projectStatus;
@property (nullable, nonatomic, copy) NSString *twitterUrl;
@property (nullable, nonatomic, copy) NSString *video;
@property (nullable, nonatomic, copy) NSString *videoUrl;
@property (nullable, nonatomic, retain) NSSet<IncubeeImage *> *incubeeImage;

@end

@interface Incubee (CoreDataGeneratedAccessors)

- (void)addIncubeeImageObject:(IncubeeImage *)value;
- (void)removeIncubeeImageObject:(IncubeeImage *)value;
- (void)addIncubeeImage:(NSSet<IncubeeImage *> *)values;
- (void)removeIncubeeImage:(NSSet<IncubeeImage *> *)values;

@end

NS_ASSUME_NONNULL_END
