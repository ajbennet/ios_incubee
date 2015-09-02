//
//  ICDataManager.m
//  Incubee
//
//  Created by Rithesh Rao on 26/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICDataManager.h"
#import "ICConstants.h"


@implementation ICDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static ICDataManager *sharedDataManagerInstance = nil;


+(ICDataManager*)sharedInstance{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedDataManagerInstance = [[self alloc] init];
    });
    
    return sharedDataManagerInstance;
}

- (id)init {
    
    if (self = [super init])
    {
         _managedObjectContext= [self managedObjectContext];
    }
    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"IncubeeModel" withExtension:@"momd"];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        
        return _persistentStoreCoordinator;
        
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"IncubeeModel.sqlite"];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:NO], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)followProject:(NSString*)incubeeId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Project" inManagedObjectContext:context]];
            
            NSPredicate *prd = [NSPredicate predicateWithFormat:@"(projectId LIKE %@)",incubeeId];
            
            [request setPredicate:prd];
            
            NSError *errorDb = nil;
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            if (results && [results count] > 0)
            {
                Project *aProject = [results objectAtIndex:0];
                
                aProject.projectFollowing = [NSNumber numberWithBool:YES];
                
                NSError *erroe = nil; [context save:&erroe];
                
                if(erroe==nil)
                {
                    NSLog(@"Project Following updated succesfully");
                }
                
            }
    }
    
}
-(void)saveProjectList:(NSArray*)inArray{
    
    NSLog(@"%@ : %@",NSStringFromSelector(_cmd),inArray);

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        for(NSDictionary *aDic in inArray)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Project" inManagedObjectContext:context]];
            
            NSError *errorDb = nil;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"projectId LIKE %@",[aDic objectForKey:@"id"]];
            
            [request setPredicate:predicate];
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            Project *aProject;
            
            if (results && [results count] > 0)
            {
                aProject = [results objectAtIndex:0];
            }
            else
            {
                aProject = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Project"
                            inManagedObjectContext:context];
            }

            aProject.companyDescription = NULL_TO_NIL([aDic objectForKey:@"description"]);
            aProject.companyName =  NULL_TO_NIL([aDic objectForKey:@"company_name"]);
            aProject.companyUrl = NULL_TO_NIL([aDic objectForKey:@"company_url"]);
            aProject.contactEmail = NULL_TO_NIL([aDic objectForKey:@"contact_email"]);
            aProject.field = NULL_TO_NIL([aDic objectForKey:@"field"]);
            aProject.founder = NULL_TO_NIL([aDic objectForKey:@"founder"]);
            aProject.funding = [NSNumber numberWithBool:([aDic objectForKey:@"funding"])];
            aProject.high_concept = NULL_TO_NIL([aDic objectForKey:@"high_concept"]);
            aProject.projectId = NULL_TO_NIL([aDic objectForKey:@"id"]);
            aProject.location = NULL_TO_NIL([aDic objectForKey:@"location"]);
            aProject.logo_url = NULL_TO_NIL([aDic objectForKey:@"logo_url"]);
            aProject.project_status = NULL_TO_NIL([aDic objectForKey:@"project_status"]);
            aProject.twitter_url= NULL_TO_NIL([aDic objectForKey:@"twitter_url"]);
            aProject.video= NULL_TO_NIL([aDic objectForKey:@"video"]);
            aProject.videoUrl=NULL_TO_NIL([aDic objectForKey:@"video_url"]);
//            aProject.projectFollowing =[NSNumber numberWithBool:NO];
            
            if(NULL_TO_NIL([aDic valueForKey:@"images"]) != nil)
            {
                // Delete all Images belong to this projectID
                
                NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
                
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"ProjectImage" inManagedObjectContext:context];

                [fetchRequest setEntity:entity];
                
                NSPredicate *prd = [NSPredicate predicateWithFormat:@"(projectId LIKE %@)",aProject.projectId];
                
                [fetchRequest setPredicate:prd];
                
                NSArray * fetchResults = [context executeFetchRequest:fetchRequest error:nil];
                
                for(ProjectImage *pImage in fetchResults)
                {
                    [context deleteObject:pImage];
                }
                
                // All Clear - InsertAll new Objects Here.
                
                NSArray *imArray = [aDic valueForKey:@"images"];
                
                for(NSString *imStringURL in imArray)
                {
                    ProjectImage *aProjectImage = aProjectImage = [NSEntityDescription
                                                                   insertNewObjectForEntityForName:@"ProjectImage"
                                                                   inManagedObjectContext:context];
                    
                    aProjectImage.imageUrl = imStringURL;
                    
                    aProjectImage.projectId = aProject.projectId;
                    
                    aProjectImage.project = aProject;
                }
            }
            
        }
        NSError *dbError = nil;
        
        [context save:&dbError];
        
        if(dbError==nil)
        {
            NSLog(@"All Projects Saved!");
        }
        else
        {
            NSLog(@"Unable to save project : %@",dbError.localizedDescription);
        }
    }
    
}

-(NSArray*)getAllProjects{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Project" inManagedObjectContext:context]];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            return results;
        }
    }
    
    return nil;
}

-(NSArray*)getFollowedProjects{

    NSArray *allProjects = [self getAllProjects];
    
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"(projectFollowing == %@)",[NSNumber numberWithBool:YES]];
    
    return ([allProjects filteredArrayUsingPredicate:prd]);

}

-(NSArray*)getImageURLs:(NSString*)inProjectId{

    
    if(inProjectId)
    {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"ProjectImage" inManagedObjectContext:context]];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"(projectId LIKE %@)",inProjectId];

        [request setPredicate:prd];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            return results;
        }
    }
    }
    return nil;


}

#pragma mark - User -
-(void)createOrUpdateGoogleUser:(GIDGoogleUser *)user{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"(email LIKE %@)",user.profile.email];
        
        [request setPredicate:prd];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];

        User *aUser;
        
        if(results.count>0)
        {
            aUser = [results objectAtIndex:0];
        }
        else
        {
            aUser = [NSEntityDescription
                        insertNewObjectForEntityForName:@"User"
                        inManagedObjectContext:context];
        }
        
        aUser.name = user.profile.name;
        
        aUser.userId = user.userID;
        
        aUser.email = user.profile.email;
        
        aUser.token = user.authentication.accessToken;
        
        aUser.tokenExpDate = user.authentication.accessTokenExpirationDate;
        
        NSError *error = nil;
        
        [context save:&error];
        
        if(error==nil)
        {
            NSLog(@"User Updated Succesfully");
        }
    }

}

-(User*)getUser{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        ;
        
        if(results.count>0)
        {
            User *aUser = [results objectAtIndex:0];
            
            return aUser;
        }
    }
    
    return nil;
    
}

-(NSString*)getUserName{

    User *aUser = [self getUser];
    
    return aUser.name;

}
-(NSString*)getUserId{

    User *aUser = [self getUser];
    
    return aUser.userId;

}

-(NSString*)getToken{

    User *aUser = [self getUser];

    return aUser.token;

}

-(void)setUserAsFounder:(NSString*)inCompanyId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context]];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        ;
        
        if(results.count>0)
        {
            User *aUser = [results objectAtIndex:0];
            
            aUser.isFounder = [NSNumber numberWithBool:YES];
            
            aUser.founderCompanyId = inCompanyId;
            
            NSError *error = nil;
            
            [context save:&error];
            
            if(error==nil)
            {
                NSLog(@"User Updated as Founder");
            }
            
        }
    }
    
}
-(BOOL)isFounder{

    User *aUser = [self getUser];
    
    return [aUser.isFounder boolValue];

}
#pragma mark - Message -

-(NSArray*)getMessages:(NSString*)inMsgId{
        
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Messages" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:entity];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"(to LIKE %@)",inMsgId];
        
        [request setPredicate:prd];

        NSError *error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if (objects != nil) {
            
            return objects;
            // Handle the error.
        }

    }
    
    return nil;

}

-(void)saveChatArray:(NSArray*)inMesgArray{

    NSLog(@"%@ : %@",NSStringFromSelector(_cmd),inMesgArray);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        for(NSDictionary *aDic in inMesgArray)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Messages" inManagedObjectContext:context]];
            
            NSError *errorDb = nil;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mid LIKE %@",[aDic objectForKey:@"mid"]];
            
            [request setPredicate:predicate];
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            Messages *aMessage;
            
            if (results && [results count] > 0)
            {
                aMessage = [results objectAtIndex:0];
            }
            else
            {
                aMessage = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Messages"
                            inManagedObjectContext:context];
            }
            
            
            
            aMessage.mid = NULL_TO_NIL([aDic objectForKey:@"mid"]);
            aMessage.to = NULL_TO_NIL([aDic objectForKey:@"to"]);
            aMessage.eid = NULL_TO_NIL([aDic objectForKey:@"eid"]);
            
            NSNumber *nTime = [NSNumber numberWithLongLong:[[aDic valueForKey:@"time"] longLongValue]];
            NSNumber *nsTime = [NSNumber numberWithLongLong:[[aDic valueForKey:@"stime"] longLongValue]] ;
            aMessage.time = [NSDate dateWithTimeIntervalSince1970:nTime.doubleValue];
            aMessage.stime = [NSDate dateWithTimeIntervalSince1970:nsTime.doubleValue];
            
            aMessage.status = NULL_TO_NIL([aDic objectForKey:@"status"]);
            aMessage.name = NULL_TO_NIL([aDic objectForKey:@"name"]);
            aMessage.body = NULL_TO_NIL([aDic objectForKey:@"body"]);
            aMessage.type = NULL_TO_NIL([aDic objectForKey:@"type"]);
            aMessage.dir = NULL_TO_NIL([aDic objectForKey:@"dir"]);
            
            long lat = [[aDic valueForKey:@"lattitude"] longValue];
            long lon = [[aDic valueForKey:@"longitude"] longValue];
            aMessage.lattitude = [NSNumber numberWithLong:lat] ;
            aMessage.longitude = [NSNumber numberWithLong:lon];
            
            aMessage.media = NULL_TO_NIL([aDic objectForKey:@"media"]);
        }
    
    
        NSError *dbError = nil;
        
        [context save:&dbError];
        
        if(dbError==nil)
        {
            NSLog(@"All Chat Saved!");
        }
        else
        {
            NSLog(@"Unable to save Chat : %@",dbError.localizedDescription);
        }

    }

}

@end
