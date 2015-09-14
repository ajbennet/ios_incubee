//
//  Incubee.h
//  Incubee
//
//  Created by Rithesh Rao on 14/09/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IncubeeImage;

@interface Incubee : NSManagedObject

@property (nonatomic, retain) NSString * companyDescription;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * companyUrl;
@property (nonatomic, retain) NSString * contactEmail;
@property (nonatomic, retain) NSString * field;
@property (nonatomic, retain) NSString * founder;
@property (nonatomic, retain) NSNumber * funding;
@property (nonatomic, retain) NSString * highConcept;
@property (nonatomic, retain) NSString * incubeeId;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSString * logoUrl;
@property (nonatomic, retain) NSNumber * projectFollowing;
@property (nonatomic, retain) NSString * projectStatus;
@property (nonatomic, retain) NSString * twitterUrl;
@property (nonatomic, retain) NSString * video;
@property (nonatomic, retain) NSString * videoUrl;
@property (nonatomic, retain) NSSet *incubeeImage;
@end

@interface Incubee (CoreDataGeneratedAccessors)

- (void)addIncubeeImageObject:(IncubeeImage *)value;
- (void)removeIncubeeImageObject:(IncubeeImage *)value;
- (void)addIncubeeImage:(NSSet *)values;
- (void)removeIncubeeImage:(NSSet *)values;

@end
