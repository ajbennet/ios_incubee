//
//  ICDataManager.h
//  Incubee
//
//  Created by Rithesh Rao on 26/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Project.h"
#import "ProjectImage.h"
#import "User.h"
#import <Google/SignIn.h>
#import "Messages.h"

@interface ICDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+(ICDataManager*)sharedInstance;

-(void)followProject:(NSString*)incubeeId;

-(void)saveProjectList:(NSArray*)inArray;

-(NSArray*)getAllProjects;

-(NSArray*)getFollowedProjects;

-(NSArray*)getImageURLs:(NSString*)inProjectId;

#pragma mark - User -
-(void)createOrUpdateGoogleUser:(GIDGoogleUser *)user;

-(User*)getUser;

-(NSString*)getUserId;

-(NSString*)getToken;


#pragma mark - Message - 

-(NSArray*)getMessages:(NSString*)inMsgId;

-(void)saveChatArray:(NSArray*)inMesgArray;

@end
