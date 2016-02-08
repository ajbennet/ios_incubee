//
//  User+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 08/02/16.
//  Copyright © 2016 Incubee. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface User (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *founderCompanyId;
@property (nullable, nonatomic, retain) NSString *imageURL;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *token;
@property (nullable, nonatomic, retain) NSDate *tokenExpDate;
@property (nullable, nonatomic, retain) NSString *userId;
@property (nullable, nonatomic, retain) NSNumber *userLoginMode;

@end

NS_ASSUME_NONNULL_END
