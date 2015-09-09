//
//  Customer.h
//  Incubee
//
//  Created by Rithesh Rao on 04/09/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Customer : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * photoUrl;
@property (nonatomic, retain) NSString * userId;

@end
