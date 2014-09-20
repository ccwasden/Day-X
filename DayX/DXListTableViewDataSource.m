//
//  DXListTableViewDataSource.m
//  DayX
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListTableViewDataSource.h"
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

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ESEntryController sharedInstance].entries.count;
    
}

@end
