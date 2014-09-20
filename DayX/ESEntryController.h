//
//  ESEntryController.h
//  Entries
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESEntry.h"

@interface ESEntryController : NSObject

@property (nonatomic, strong, readonly) NSArray *entries;

+ (ESEntryController *)sharedInstance;

- (void)addEntry:(ESEntry *)entry;
- (void)removeEntry:(ESEntry *)entry;
- (void)replaceEntry:(ESEntry *)oldEntry withEntry:(ESEntry *)newEntry;
- (void)loadFromDefaults;
- (void)synchronize;

@end
