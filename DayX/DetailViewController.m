//
//  DetailViewController.m
//  DayX
//
//  Created by Zack Lounsbury on 9/16/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "ESEntryController.h"
#import "ESEntry.h"

#import <QuartzCore/QuartzCore.h>

static NSString *entryKey = @"entry";
static NSString *titleKey = @"title";
static NSString *textKey = @"text";

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic) ESEntry *detailEntry;

@property (strong, nonatomic) IBOutlet UITextField *detailTitle;
@property (strong, nonatomic) IBOutlet UITextView *detailText;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.detailTitle.delegate = self;
    self.detailText.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.detailText.layer.borderWidth = 1.0f;
    self.detailText.layer.borderColor = [[UIColor grayColor] CGColor];
    self.detailText.layer.cornerRadius = 8;
    
    [self updateWithEntry:self.detailEntry];
    
}


- (IBAction)clearButton:(id)sender {
    
    self.detailTitle.text = @"";
    self.detailText.text = @"";
    //[self save];
   
}

/*
- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    NSString *title = [dictionary objectForKey:titleKey];
    
    if (title) {
        self.detailTitle.text = title;
    }
    
    NSString *text = [dictionary objectForKey:textKey];
    
    if (text) {
        self.detailText.text = text;
    }
    
}
*/

- (void)updateEntry:(ESEntry *)entry {
    
    self.detailEntry = entry;
}

- (void)updateWithEntry:(ESEntry *)entry {
    
    self.detailEntry = entry;
    
    if (entry.title) {
        self.detailTitle.text = entry.title;
    }
    //else {
        //self.detailTitle.placeholder = @"Title";
    //}
    
    if (entry.text) {
        self.detailText.text = entry.text;
    }
    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self save];
}

- (void)save {
    
    //create a new entry, send that entry to make it a dictionary and save it?
    
    
    ESEntry *newEntry = [ESEntry new];
    
    if (self.detailEntry == nil) {
        // We need to add a new entry to ESEntryController
        newEntry.title = self.detailTitle.text;
        newEntry.text = self.detailText.text;
        [[ESEntryController sharedInstance] addEntry:newEntry];
    }
    else {
        
        // The entry already exists and we need to replace the old one with the new
        newEntry.title = self.detailTitle.text;
        newEntry.text = self.detailText.text;
        [[ESEntryController sharedInstance] replaceEntry:self.detailEntry withEntry:newEntry];
    }
    
    //[[ESEntryController sharedInstance] synchronize];
    
    NSLog(@"HERE");
    
    /*
    NSMutableDictionary *data = [NSMutableDictionary new];
    
    [data setObject:self.detailTitle.text forKey:titleKey];
    [data setObject:self.detailText.text forKey:textKey];
    
    
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:entryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    */
    
}

/*
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    //[self save];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    //[self save];
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.detailTitle resignFirstResponder];
    
    return YES;
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
