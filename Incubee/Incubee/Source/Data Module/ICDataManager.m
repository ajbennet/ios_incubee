//
//  ICDataManager.m
//  Incubee
//
//  Created by Rithesh Rao on 26/06/15.
//  Copyright (c) 2015 Incubee. All rights reserved.
//

#import "ICDataManager.h"

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })


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
            aProject.projectFollowing =[NSNumber numberWithBool:NO];
            
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
@end