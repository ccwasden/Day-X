//
//  DXListTableViewDataSource.m
//  DayX
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListTableViewDataSource.h"
#import "DXListViewController.h"
#import "ESEntryController.h"
#import "ESEntry.h"

static NSString *titleKey = @"title";

@implementation DXListTableViewDataSource

- (void) registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    ESEntry *entry = [ESEntryController sharedInstance].entries[indexPath.row];
    
    
    cell.textLabel.text = entry.title;
    cell.backgroundColor = entry.color;
    if (entry.color != [UIColor whiteColor]) {
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:25];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ESEntryController sharedInstance].entries.count;
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        ESEntry *toRemove = [ESEntryController sharedInstance].entries[indexPath.row];
        
        [[ESEntryController sharedInstance] removeEntry:toRemove];
        
        [tableView reloadData];
    }

}
 


// This doesn't work...
/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView
        moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
        toIndexPath:(NSIndexPath *)toIndexPath {
    
    ESEntry *firstEntry = [ESEntryController sharedInstance].entries[fromIndexPath.row];
    ESEntry *secondEntry = [ESEntryController sharedInstance].entries[toIndexPath.row];
    
    [[ESEntryController sharedInstance] switchEntry:firstEntry withEntry:secondEntry];
    
}
 */


@end
