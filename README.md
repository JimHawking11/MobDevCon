MobDevCon
=========

Shell project for Chicago MobDevCon Lab

AF Networking

-Basic Block for AF Networking Call

    NSURL *url = [NSURL URLWithString:connectionString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

Mantle

//Key Map

    + (NSDictionary *)JSONKeyPathsByPropertyKey {
        return @{
                 @"variableName": @"JSON Key",
                 @"variableName2": @"JSON Key 2",
                 };
    }

//Transformers

    + (NSValueTransformer *)dateJSONTransformer {
    
        return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
            return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
        } reverseBlock:^(NSDate *date) {
            return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
        }];
    }

    + (NSValueTransformer *)tempJSONTransformer {
        return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *calvin) {
            float temp = ((calvin.floatValue - CALVIN_TO_CELSIUS) * 1.8f) + 32;
            return @(temp);
        } reverseBlock:^(NSNumber *fahrenheit) {
            float temp = ((fahrenheit.floatValue - 32) / 1.8f) - CALVIN_TO_CELSIUS;
            return @(temp);
        }];
    }

    + (NSValueTransformer *)sunriseJSONTransformer {
       return [self dateJSONTransformer];
    }

    + (NSValueTransformer *)temperatureJSONTransformer {
        return [self tempJSONTransformer];
    }

    + (NSValueTransformer *)conditionDescriptionJSONTransformer {
        return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
            return [values firstObject];
        } reverseBlock:^(NSString *str) {
            return @[str];
        }];
    }

    + (NSValueTransformer *)ownerJSONTransformer {
        return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:CATOwner.class];
    }

    + (NSValueTransformer *)friendsJSONTransformer {
        return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:CATFriend.class];
    }

    //Object Creation
    MTLObject *weather = [MTLJSONAdapter modelOfClass:MTLObject.class fromJSONDictionary:responseObject error:NULL];

Core Data

//In .h

    @property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
    @property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
    @property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

    - (NSURL *)applicationDocumentsDirectory;
    - (void) saveContext;

//In .m

    - (NSManagedObjectContext *)managedObjectContext{
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

    - (NSManagedObjectModel *)managedObjectModel{
        if (_managedObjectModel != nil) {
            return _managedObjectModel;
        }
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MODELNAME" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        return _managedObjectModel;
    }

    - (NSPersistentStoreCoordinator *)persistentStoreCoordinator
    {
        if (_persistentStoreCoordinator != nil) {
            return _persistentStoreCoordinator;
        }
    
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MODELNAME.sqlite"];
    
        NSError *error = nil;
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self    managedObjectModel]];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    
        return _persistentStoreCoordinator;
    }

// Returns the URL to the application's Documents directory.

    - (NSURL *)applicationDocumentsDirectory{
        return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    }

    - (void)saveContext{
        NSError *error = nil;
        NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
        if (managedObjectContext != nil) {
            if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
            }
        }
    }

//Add Item to Store
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *modelInfo = [NSEntityDescription
                                       insertNewObjectForEntityForName:@"ENTITY NAME"
                                       inManagedObjectContext:context];
    [modelInfo setValue:@"" forKey:@"KEY NAME"];
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate saveContext];
