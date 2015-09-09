//
//  User.h
//  Incubee
//
//  Created by Rithesh Rao on 04/09/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * founderCompanyId;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * isFounder;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * token;
@property (nonatomic, retain) NSDate * tokenExpDate;
@property (nonatomic, retain) NSString * userId;

@end
