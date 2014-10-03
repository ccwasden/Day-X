//
//  ESEntryController.h
//  Entries
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface ESEntryController : NSObject

+ (ESEntryController *)sharedInstance;

- (void)addEntryWithTitle:(NSString *)title text:(NSString *)text date:(NSDate *)date;
- (void)removeEntry:(Entry *)entry;
- (void)synchronize;
- (NSArray *)entries;

@end
