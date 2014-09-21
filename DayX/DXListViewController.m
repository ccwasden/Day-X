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
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    self.title = @"Day X";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.dataSource = [DXListTableViewDataSource new];
    self.tableView.dataSource = self.dataSource;
    [self.dataSource registerTableView:self.tableView];
    
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                           target:self action:@selector(addDetailView:)];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

- (void)addDetailView:(UIBarButtonItem *) sender {
    
    DetailViewController *detailViewController = [DetailViewController new];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailViewController = [DetailViewController new];
    
    ESEntry *editEntry = [ESEntryController sharedInstance].entries[indexPath.row];
    
    [detailViewController updateEntry:editEntry];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

