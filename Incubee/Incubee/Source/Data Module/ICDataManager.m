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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"IncubeeModei.sqlite"];
    
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

#pragma mark - Incubee -

-(void)followProject:(NSString*)incubeeId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
            
            NSPredicate *prd = [NSPredicate predicateWithFormat:@"(incubeeId LIKE %@)",incubeeId];
            
            [request setPredicate:prd];
            
            NSError *errorDb = nil;
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            if (results && [results count] > 0)
            {
                Incubee *aIncubee = [results objectAtIndex:0];
                
                aIncubee.projectFollowing = [NSNumber numberWithBool:YES];
                
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
            
            [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
            
            NSError *errorDb = nil;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"incubeeId LIKE %@",[aDic objectForKey:@"id"]];
            
            [request setPredicate:predicate];
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            Incubee *aIncubee;
            
            if (results && [results count] > 0)
            {
                aIncubee = [results objectAtIndex:0];
            }
            else
            {
                aIncubee = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Incubee"
                            inManagedObjectContext:context];
            }

            aIncubee.companyDescription = NULL_TO_NIL([aDic objectForKey:@"description"]);
            aIncubee.companyName =  NULL_TO_NIL([aDic objectForKey:@"company_name"]);
            aIncubee.companyUrl = NULL_TO_NIL([aDic objectForKey:@"company_url"]);
            aIncubee.contactEmail = NULL_TO_NIL([aDic objectForKey:@"contact_email"]);
            aIncubee.field = NULL_TO_NIL([aDic objectForKey:@"field"]);
            aIncubee.founder = NULL_TO_NIL([aDic objectForKey:@"founder"]);
            aIncubee.funding = [NSNumber numberWithBool:((BOOL)[aDic objectForKey:@"funding"])];
            aIncubee.highConcept = NULL_TO_NIL([aDic objectForKey:@"high_concept"]);
            aIncubee.incubeeId = NULL_TO_NIL([aDic objectForKey:@"id"]);
            aIncubee.location = NULL_TO_NIL([aDic objectForKey:@"location"]);
            aIncubee.logoUrl = NULL_TO_NIL([aDic objectForKey:@"logo_url"]);
            aIncubee.projectStatus = NULL_TO_NIL([aDic objectForKey:@"project_status"]);
            aIncubee.twitterUrl= NULL_TO_NIL([aDic objectForKey:@"twitter_url"]);
            aIncubee.video= NULL_TO_NIL([aDic objectForKey:@"video"]);
            aIncubee.videoUrl=NULL_TO_NIL([aDic objectForKey:@"video_url"]);
//            aProject.projectFollowing =[NSNumber numberWithBool:NO];
            
            if(NULL_TO_NIL([aDic valueForKey:@"images"]) != nil)
            {
                // Delete all Images belong to this projectID
                
                NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
                
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"IncubeeImage" inManagedObjectContext:context];

                [fetchRequest setEntity:entity];
                
                NSPredicate *prd = [NSPredicate predicateWithFormat:@"(incubeeId LIKE %@)",aIncubee.incubeeId];
                
                [fetchRequest setPredicate:prd];
                
                NSArray * fetchResults = [context executeFetchRequest:fetchRequest error:nil];
                
                for(IncubeeImage *pImage in fetchResults)
                {
                    [context deleteObject:pImage];
                }
                
                // All Clear - InsertAll new Objects Here.
                
                NSArray *imArray = [aDic valueForKey:@"images"];
                
                for(NSString *imStringURL in imArray)
                {
                    IncubeeImage *aIncubeeImage = [NSEntityDescription
                                                                   insertNewObjectForEntityForName:@"IncubeeImage"
                                                                   inManagedObjectContext:context];
                    
                    aIncubeeImage.imageUrl = imStringURL;
                    
                    aIncubeeImage.incubeeId = aIncubee.incubeeId;
                    
                    aIncubeeImage.incubee = aIncubee;
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

-(NSArray*)getAllIncubees{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
        
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

    NSArray *allProjects = [self getAllIncubees];
    
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"(projectFollowing == %@)",[NSNumber numberWithBool:YES]];
    
    return ([allProjects filteredArrayUsingPredicate:prd]);

}

-(NSArray*)getAllCustomer{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            return results;
        }
    }
    
    return nil;
}

-(NSArray*)getImageURLs:(NSString*)inProjectId{

    
    if(inProjectId)
    {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"IncubeeImage" inManagedObjectContext:context]];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"(incubeeId LIKE %@)",inProjectId];

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

-(int)getIncubeeUnreadCount:(NSString*)incubeeId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Messages" inManagedObjectContext:context]];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"((to LIKE %@) AND (status LIKE %@) AND (dir LIKE %@))",incubeeId,@"NEW",@"I"];
        
        [request setPredicate:prd];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];

        if (results && [results count] > 0)
        {
            return ((int)results.count);
        }
    }
    
    return 0;
    
}

-(Incubee*)getIncubee:(NSString*)incubeeId{

    NSManagedObjectContext *context = [self managedObjectContext];

    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"(incubeeId LIKE %@)",incubeeId];
        
        [request setPredicate:prd];

        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            Incubee *aIncubee = [results objectAtIndex:0];
            
            return aIncubee;
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
        
        if (user.profile.hasImage)
        {
            NSUInteger dimension = 200;
            
            NSURL *imageURL = [user.profile imageURLWithDimension:dimension];
            
            aUser.imageURL = [imageURL absoluteString];
        }

                
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
            
            aUser.userLoginMode = [NSNumber numberWithInt:USER_LOGIN_MODE_FOUNDER];
            
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

-(void)setUserMode:(USER_LOGIN_MODE)inUserLoginMode{

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
            
            aUser.userLoginMode = [NSNumber numberWithInt:inUserLoginMode];
            
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
    
    return ([aUser.userLoginMode integerValue] == USER_LOGIN_MODE_FOUNDER ) ? YES : NO;

}

-(BOOL)isInvestor{

    User *aUser = [self getUser];
    
    return ([aUser.userLoginMode integerValue] == USER_LOGIN_MODE_INVESTOR ) ? YES : NO;
    
}

-(BOOL)isChatEnabled{

    User *aUser = [self getUser];
    
    return (([aUser.userLoginMode integerValue] == USER_LOGIN_MODE_CUSTOMER) || ([aUser.userLoginMode integerValue] == USER_LOGIN_MODE_FOUNDER) ) ? YES : NO;

}

-(NSString*)getFounderId{
    
    User *aUser = [self getUser];
    
    return aUser.founderCompanyId;
    
}

-(USER_LOGIN_MODE)getUserLoginMode{
    
    return USER_LOGIN_MODE_GUEST;
    
}

-(NSString*)getUserProfilePic{

    User *aUser = [self getUser];
    
    return aUser.imageURL;

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
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"stime" ascending:YES];
        
        [request setSortDescriptors:@[sortDescriptor]];
        
        NSError *error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if (objects != nil) {
            
            return objects;
            // Handle the error.
        }

    }
    
    return nil;

}

-(void)saveLikedArray:(NSArray*)inLikedArray{

    NSLog(@"%@ : %@",NSStringFromSelector(_cmd),inLikedArray);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
    
        for(NSString *incubId in inLikedArray)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
            
            NSError *errorDb = nil;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"incubeeId LIKE %@",incubId];
            
            [request setPredicate:predicate];
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            if(results.count>0)
            {
                Incubee *aIncubee = [results objectAtIndex:0];
            
                aIncubee.projectFollowing = [NSNumber numberWithBool:YES];
            }            
        }
        
        NSError *er = nil;
        
        [context save:&er];
        
        if(er==nil)
        {
            NSLog(@"Saved Liked projects");
        }
        
    }
}

-(void)saveCustomerArray:(NSArray*)inLikedArray{
    
    NSLog(@"%@ : %@",NSStringFromSelector(_cmd),inLikedArray);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        for(NSString *userId in inLikedArray)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId LIKE %@",userId];
            
            [request setPredicate:predicate];
            
            NSError *errorDb = nil;
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            Customer *aCustomer;
            
            if (results && [results count] > 0)
            {
                aCustomer = [results objectAtIndex:0];
            }
            else
            {
                aCustomer = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Customer"
                            inManagedObjectContext:context];
            }

            aCustomer.userId = userId;
            
        }

        NSError *er = nil;
        
        [context save:&er];
        
        if(er==nil)
        {
            NSLog(@"Saved Customer");
        }
        
    }
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
            aMessage.time = [NSDate dateWithTimeIntervalSince1970:(nTime.doubleValue)/1000];
            aMessage.stime = [NSDate dateWithTimeIntervalSince1970:(nsTime.doubleValue)/1000];
            
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

-(void)updateCustomerDetails:(NSDictionary*)inCustomer{
    
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId LIKE %@",[inCustomer valueForKey:@"id"]];
            
            [request setPredicate:predicate];
            
            NSError *errorDb = nil;
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            Customer *aCustomer;
            
            if (results && [results count] > 0)
            {
                aCustomer = [results objectAtIndex:0];
            }
            else
            {
                aCustomer = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Customer"
                             inManagedObjectContext:context];
            }
                        
            aCustomer.userName = NULL_TO_NIL([inCustomer valueForKey:@"name"]);
            
            aCustomer.imageUrl = NULL_TO_NIL([inCustomer valueForKey:@"image_url"]);

            aCustomer.email = NULL_TO_NIL([inCustomer valueForKey:@"email"]);
        
        NSError *er = nil;
        
        [context save:&er];
        
        if(er==nil)
        {
            NSLog(@"Updated Customer");
        }
        
    }
}
}

-(NSString*)getCustomerName:(NSString*)inCustomerId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId LIKE %@",inCustomerId];
    
    [request setPredicate:predicate];
    
    NSError *errorDb = nil;
    
    NSArray *results = [context executeFetchRequest:request error:&errorDb];
    
    Customer *aCustomer;
    
    if (results && [results count] > 0)
    {
        aCustomer = [results objectAtIndex:0];
        
        return aCustomer.userName;
    }
}
    return nil;

}

-(NSString*)getCustomerPic:(NSString*)inCustomerId{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Customer" inManagedObjectContext:context]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId LIKE %@",inCustomerId];
        
        [request setPredicate:predicate];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        Customer *aCustomer;
        
        if (results && [results count] > 0)
        {
            aCustomer = [results objectAtIndex:0];
            
            return aCustomer.imageUrl;
        }
    }
    return nil;
    
}


-(NSString*)getIncubeeName:(NSString*)inIncubeeId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"incubeeId LIKE %@",inIncubeeId];
        
        [request setPredicate:predicate];

        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            Incubee *incubee = (Incubee*)[results objectAtIndex:0];
            
            return incubee.companyName;
        }
    }
    
    return nil;
    
}

-(NSArray*)getAllSavedIncubeeChatArray{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Messages" inManagedObjectContext:context]];
        
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K BEGINSWITH[cd] %@",@"to",@"inc"];
        
        [request setPredicate:pre];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            NSMutableArray *chatArray = [[NSMutableArray alloc]init];
            
            NSSet *onGoingChatIncubee = [NSSet setWithArray:[results valueForKey:@"to"]];
            
            for(NSString *incubeeChat in onGoingChatIncubee)
            {
                Incubee *incubee = [self getIncubee:incubeeChat];
                
                int newCount = [self getIncubeeUnreadCount:incubeeChat];
                
                NSDictionary *chatDic = [[NSDictionary alloc] initWithObjectsAndKeys:incubee,@"CHAT_INCUBEE",[NSNumber numberWithInt:newCount],@"CHAT_COUNT",nil];
                
                [chatArray addObject:chatDic];
            }
            
            return chatArray;
            
        }
        
    }
    return nil;

}

-(NSString*)getIncubeeImageUrl:(NSString*)inIncubeeId{
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Incubee" inManagedObjectContext:context]];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"incubeeId LIKE %@",inIncubeeId];
        
        [request setPredicate:predicate];
        
        NSError *errorDb = nil;
        
        NSArray *results = [context executeFetchRequest:request error:&errorDb];
        
        if (results && [results count] > 0)
        {
            Incubee *incubee = (Incubee*)[results objectAtIndex:0];
            
            NSString *icUrl = incubee.companyName;
        }
    }
    
    return nil;
    
}

#pragma mark - Review -
-(void)saveReviewArray:(NSArray*)inReviewArray{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        for(NSDictionary *aDic in inReviewArray)
        {
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            
            [request setEntity:[NSEntityDescription entityForName:@"Review" inManagedObjectContext:context]];
            
            NSError *errorDb = nil;
            
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"incubee_id LIKE %@ AND user_id LIKE %@",[aDic objectForKey:@"incubee_id"],[aDic objectForKey:@"user_id"]];
            
            [request setPredicate:predicate];
            
            NSArray *results = [context executeFetchRequest:request error:&errorDb];
            
            Review *aReview;
            
            if (results && [results count] > 0)
            {
                aReview = [results objectAtIndex:0];
            }
            else
            {
                aReview = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Review"
                            inManagedObjectContext:context];
            }
            
            aReview.incubee_id = NULL_TO_NIL([aDic objectForKey:@"incubee_id"]);
            aReview.reviewTitle = NULL_TO_NIL([aDic objectForKey:@"title"]);
            aReview.reviewDescription = NULL_TO_NIL(([aDic objectForKey:@"description"]));
            aReview.rating = ([NSNumber numberWithInt:[[aDic valueForKey:@"rating"] intValue]]);
            aReview.user_id = NULL_TO_NIL([aDic objectForKey:@"user_id"]);
            
            aReview.meeting = NULL_TO_NIL([aDic objectForKey:@"meeting"]);
            aReview.status = NULL_TO_NIL([aDic objectForKey:@"status"]);
            
            NSNumber *nsTime = [NSNumber numberWithLongLong:[[aDic valueForKey:@"date"] longLongValue]] ;

            aReview.date = [NSDate dateWithTimeIntervalSince1970:(nsTime.doubleValue)/1000];
            
            aReview.replies = ([NSNumber numberWithInt:[[aDic valueForKey:@"replies"] intValue]]);
            
            aReview.views = ([NSNumber numberWithInt:[[aDic valueForKey:@"views"] intValue]]);
            
            aReview.likes = ([NSNumber numberWithInt:[[aDic valueForKey:@"likes"] intValue]]);
            
            aReview.dislikes = ([NSNumber numberWithInt:[[aDic valueForKey:@"dislikes"] intValue]]);
            
        }
        
        
        NSError *dbError = nil;
        
        [context save:&dbError];
        
        if(dbError==nil)
        {
            NSLog(@"All Review Saved!");
        }
        else
        {
            NSLog(@"Unable to save review : %@",dbError.localizedDescription);
        }
        
    }

}

-(NSArray*)getReviewArray:(NSString*)inIncubeeId{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    if(context)
    {
        NSEntityDescription *entity = [NSEntityDescription  entityForName:@"Review" inManagedObjectContext:context];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        [request setEntity:entity];
        
        NSPredicate *prd = [NSPredicate predicateWithFormat:@"(incubee_id LIKE %@)",inIncubeeId];
        
        [request setPredicate:prd];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        
        [request setSortDescriptors:@[sortDescriptor]];
        
        NSError *error = nil;
        
        NSArray *objects = [context executeFetchRequest:request error:&error];
        
        if (objects != nil) {
            
            return objects;
            // Handle the error.
        }
        
    }
    
    
    return nil;

}

@end
