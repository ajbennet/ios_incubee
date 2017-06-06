//
//  Review+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Review+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Review (CoreDataProperties)

+ (NSFetchRequest<Review *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *date;
@property (nullable, nonatomic, copy) NSNumber *dislikes;
@property (nullable, nonatomic, copy) NSString *incubee_id;
@property (nullable, nonatomic, copy) NSNumber *likes;
@property (nullable, nonatomic, copy) NSString *meeting;
@property (nullable, nonatomic, copy) NSNumber *rating;
@property (nullable, nonatomic, copy) NSNumber *replies;
@property (nullable, nonatomic, copy) NSString *reviewDescription;
@property (nullable, nonatomic, copy) NSString *reviewTitle;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSString *user_id;
@property (nullable, nonatomic, copy) NSNumber *views;
@property (nullable, nonatomic, copy) NSString *review_id;

@end

NS_ASSUME_NONNULL_END
