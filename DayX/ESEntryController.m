//
//  ESEntryController.m
//  Entries
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ESEntryController.h"
#import "Stack.h"

@interface ESEntryController ()

@end

@implementation ESEntryController

+ (ESEntryController *)sharedInstance {
    static ESEntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ESEntryController alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)entries {
    
    //THIS REQUEST IS HOW YOU GET OBJECTS
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Entry"];
    NSArray *array = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
    
    return array;
}

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date {
    
    if ([title isEqualToString:@""]) {
        if ([text isEqualToString:@""]) {
            return;
        }
        else {
            title = @"New Note";
        }
    }
    
    //THIS IS HOW YOU CREATE A NEW INSTANCE IN YOUR MANAGED OBJECT CONTEXT
    Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    entry.title = title;
    entry.text = text;
    entry.timestamp = date;
    
    [self synchronize];
}

- (void)removeEntry:(Entry *)entry {
    
    [[Stack sharedInstance].managedObjectContext deleteObject:entry];
    
    // [entry.managedObjectContext deleteObject:entry]; // Safer for multiple managedObjectContexts
    
    [self synchronize];
    
}

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:nil];
    
}



@end






