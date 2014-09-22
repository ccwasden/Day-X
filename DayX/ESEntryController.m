//
//  ESEntryController.m
//  Entries
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ESEntryController.h"

@interface ESEntryController ()

@property (nonatomic, strong) NSArray *entries;

@end

@implementation ESEntryController

- (id)init {
    self = [super init];
    
    self.entries = @[];
    
    return self;
}

+ (ESEntryController *)sharedInstance {
    static ESEntryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ESEntryController alloc] init];
        
        //sharedInstance.entries = @[];
        
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)addEntry:(ESEntry *)entry {
    
    NSMutableArray *mutabaleEntries = [self.entries mutableCopy];
    
    // Don't save the note if nothing was changed
    if ([entry.title  isEqual: @""] && [entry.text  isEqual: @""]) {}
    else if ([entry.title isEqual: @""]) {
        /* Save note with date?
         NSDate *date = [NSDate new];
         entry.title = [NSString stringWithFormat:@"New Note %@",date];
         */
        entry.title = @"New Note";
        [mutabaleEntries addObject:entry];
    }
    else {
        [mutabaleEntries addObject:entry];
    }
    
    self.entries = [mutabaleEntries copy];
    [self synchronize];
    
}

- (void)removeEntry:(ESEntry *)entry {
    
    NSMutableArray *mutableEntries = [self.entries mutableCopy];
    
    [mutableEntries removeObject:entry];
    
    self.entries = [mutableEntries copy];
    [self synchronize];
    
}

- (void)replaceEntry:(ESEntry *)oldEntry withEntry:(ESEntry *)newEntry {
    
    if ([self.entries containsObject:oldEntry]) {
        
        NSMutableArray *mutableEntries = [self.entries mutableCopy];
        
        NSUInteger index = [mutableEntries indexOfObject:oldEntry];
        [mutableEntries replaceObjectAtIndex:index withObject:newEntry];
        
        self.entries = [mutableEntries copy];
        [self synchronize];
    }
    
}


/*
- (void)switchEntry:(ESEntry *)firstEntry withEntry:(ESEntry *)secondEntry {
    
    NSMutableArray *entries = [self.entries mutableCopy];
    
    NSUInteger index1 = [entries indexOfObject:firstEntry];
    NSUInteger index2 = [entries indexOfObject:secondEntry];
    
    [entries replaceObjectAtIndex:index2 withObject:firstEntry];
    [entries replaceObjectAtIndex:index1 withObject:secondEntry];
    
    self.entries = [entries copy];
    [self synchronize];
    
    
}
 */

- (void)loadFromDefaults {
    
    NSArray *entryDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:@"entries"];
    
    NSMutableArray *entries = [NSMutableArray new];
    
    for (int i = 0; i < entryDictionaries.count; i++) {
        
        NSDictionary * dictionary = entryDictionaries[i];
        ESEntry *entry = [[ESEntry alloc] initWithDictionary:dictionary];
        [entries addObject:entry];
    }
    
    if (entries) {
        self.entries = entries;
    }
    
}

- (void)synchronize {
    
    NSMutableArray *dictionaryEntries = [NSMutableArray new];
    
    for (ESEntry *entry in self.entries) {
        
        [dictionaryEntries addObject:[entry entryToDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dictionaryEntries forKey:@"entries"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end






