//
//  Messages+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Messages+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Messages (CoreDataProperties)

+ (NSFetchRequest<Messages *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *body;
@property (nullable, nonatomic, copy) NSString *dir;
@property (nullable, nonatomic, copy) NSString *eid;
@property (nullable, nonatomic, copy) NSNumber *lattitude;
@property (nullable, nonatomic, copy) NSNumber *longitude;
@property (nullable, nonatomic, copy) NSString *media;
@property (nullable, nonatomic, copy) NSString *mid;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *status;
@property (nullable, nonatomic, copy) NSDate *stime;
@property (nullable, nonatomic, copy) NSDate *time;
@property (nullable, nonatomic, copy) NSString *to;
@property (nullable, nonatomic, copy) NSString *type;

@end

NS_ASSUME_NONNULL_END
