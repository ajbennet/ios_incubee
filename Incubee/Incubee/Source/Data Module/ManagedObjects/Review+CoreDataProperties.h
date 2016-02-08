//
//  Review+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 08/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Review.h"

NS_ASSUME_NONNULL_BEGIN

@interface Review (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *dislikes;
@property (nullable, nonatomic, retain) NSString *incubee_id;
@property (nullable, nonatomic, retain) NSNumber *likes;
@property (nullable, nonatomic, retain) NSString *meeting;
@property (nullable, nonatomic, retain) NSNumber *rating;
@property (nullable, nonatomic, retain) NSNumber *replies;
@property (nullable, nonatomic, retain) NSString *reviewDescription;
@property (nullable, nonatomic, retain) NSString *reviewTitle;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSString *user_id;
@property (nullable, nonatomic, retain) NSNumber *views;

@end

NS_ASSUME_NONNULL_END
