//
//  Messages.h
//  Incubee
//
//  Created by Rithesh Rao on 14/09/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Messages : NSManagedObject

@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * dir;
@property (nonatomic, retain) NSString * eid;
@property (nonatomic, retain) NSNumber * lattitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * media;
@property (nonatomic, retain) NSString * mid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSDate * stime;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * to;
@property (nonatomic, retain) NSString * type;

@end
