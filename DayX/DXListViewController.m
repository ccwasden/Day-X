//
//  DXListViewController.m
//  DayX
//
//  Created by Zack Lounsbury on 9/18/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DXListViewController.h"
#import "DXListTableViewDataSource.h"
#import "DetailViewController.h"
#import "ESEntryController.h"

@interface DXListViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DXListTableViewDataSource *dataSource;

@end

@implementation DXListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Quick Note";
    
    UIBarButtonItem *backText = [UIBarButtonItem new];
    backText.title = @"";
    self.navigationItem.backBarButtonItem = backText;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                                                                            UIBarButtonSystemItemCompose
                                                                                           target:self action:@selector(addDetailView:)];

    
    self.tableView = [UITableView new];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.dataSource = [DXListTableViewDataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    NSArray * vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tableView]-|" options:0 metrics:nil views:@{@"tableView":self.tableView}];
    NSArray * hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[tableView]-|" options:0 metrics:nil views:@{@"tableView":self.tableView}];
    [self.view addConstraints:vConstraints];
    [self.view addConstraints:hConstraints];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(scrollView.contentOffset.y + scrollView.contentInset.top < -55) {
        DetailViewController *detailViewController = [DetailViewController new];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
}

    
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}

- (void)addDetailView:(id) sender {
    
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailViewController = [DetailViewController new];
    
    Entry *editEntry = [ESEntryController sharedInstance].entries[indexPath.row];
    
    [detailViewController updateEntry:editEntry];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.tableView.showsHorizontalScrollIndicator = YES;
}



@end

