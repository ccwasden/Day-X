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
@property (nonatomic, strong) UIColor *favoriteColor;
@property (nonatomic, strong) NSNumber *favoriteNumber;

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
    
    [mutabaleEntries addObject:entry];
    
    self.entries = [mutabaleEntries copy];
    [self synchronize];
    
}

- (void)removeEntry:(ESEntry *)entry {
    
    NSMutableArray *mutableEntries = [self.entries mutableCopy];
    
    [mutableEntries removeObject:entry];
    
    self.entries = [mutableEntries copy];
    [self synchronize];
    
}

- (void)replaceEntry:(ESEntry *)oldEntry withEntry:(NSDictionary *)newEntry {
    
    if ([self.entries containsObject:oldEntry]) {
        
        NSMutableArray *mutableEntries = [self.entries mutableCopy];
        
        NSUInteger index = [mutableEntries indexOfObject:oldEntry];
        [mutableEntries replaceObjectAtIndex:index withObject:newEntry];
        
        self.entries = [mutableEntries copy];
        [self synchronize];
    }
    
}

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
        
        //NSDictionary *dictionaryFromEntry = [entry entryToDictionary];
        //[dictionaryEntries addObject:dictionaryFromEntry];
        
        [dictionaryEntries addObject:[entry entryToDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:dictionaryEntries forKey:@"entries"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end






