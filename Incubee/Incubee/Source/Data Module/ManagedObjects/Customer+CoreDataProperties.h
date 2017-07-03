//
//  Customer+CoreDataProperties.h
//  Incubee
//
//  Created by Rithesh Rao on 07/06/17.
//  Copyright © 2017 Incubee. All rights reserved.
//

#import "Customer+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Customer (CoreDataProperties)

+ (NSFetchRequest<Customer *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *imageUrl;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *userName;

@end

NS_ASSUME_NONNULL_END
