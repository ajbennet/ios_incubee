//
//  ProjectImage.h
//  Incubee
//
//  Created by Rithesh Rao on 31/08/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface ProjectImage : NSManagedObject

@property (nonatomic, retain) NSString * imageUrl;
@property (nonatomic, retain) NSString * projectId;
@property (nonatomic, retain) Project *project;

@end
