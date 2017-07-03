//
//  User+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "User+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

+ (NSFetchRequest<User *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *founderCompanyId;
@property (nullable, nonatomic, copy) NSString *imageURL;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *token;
@property (nullable, nonatomic, copy) NSDate *tokenExpDate;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSNumber *userLoginMode;

@end

NS_ASSUME_NONNULL_END
