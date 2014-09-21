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
    
    // Set up detailView if entry properties exist
    if (self.detailEntry.title != nil) {
        self.title = self.detailEntry.title;
        self.detailTitle.text = self.detailEntry.title;
        
    }
    else {
        self.detailTitle.placeholder = @"Title";
    }
    
    if (self.detailEntry.text != nil) {
        self.detailText.text = self.detailEntry.text;
    }
    else {
        //self.detailText.textColor = [UIColor lightGrayColor];
        self.detailText.text = @"Notes...";
    }
    

    // Set which items will be editable first
    if ([self.detailTitle.text isEqual:@""]) {
        [self.detailTitle becomeFirstResponder];
    }
    else if ([self.detailText.text isEqual:@"Notes..."]){
        [self.detailText setSelectedTextRange:[self.detailText
                                               textRangeFromPosition:self.detailText.beginningOfDocument
                                               toPosition:self.detailText.endOfDocument]];
        [self.detailText becomeFirstResponder];
    }
    
    
    //self.view.backgroundColor = [UIColor blueColor];
    //self.detailTitle.textColor = [UIColor whiteColor];
    
    
}


- (IBAction)clearButton:(id)sender {
    
    self.detailTitle.text = @"";
    self.detailTitle.placeholder = @"Title";
    self.detailText.text = @"";
    //[self save];
   
}


- (void)updateEntry:(ESEntry *)entry {
    
    self.detailEntry = entry;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [self save];
}

- (void)save {
    
    ESEntry *newEntry = [ESEntry new];
    newEntry.title = self.detailTitle.text;
    newEntry.text = self.detailText.text;
    
    if (self.detailEntry == nil) {
        // We need to add a new entry to ESEntryController
        [[ESEntryController sharedInstance] addEntry:newEntry];
    }
    else {
        
        // If we cleared it should it delete it?
        if ([self.detailTitle.text isEqual:@""] && [self.detailText.text isEqual:@""]) {
            [[ESEntryController sharedInstance] removeEntry:self.detailEntry];
        }
        
        // The entry already exists and we need to replace the old one with the new
        [[ESEntryController sharedInstance] replaceEntry:self.detailEntry withEntry:newEntry];
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField  {
    
    self.title = textField.text;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqual:@""]) {
        textView.text = @"Notes...";
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.detailTitle resignFirstResponder];
    
    if ([self.detailText.text isEqual:@"Notes..."]) {
        [self.detailText setSelectedTextRange:[self.detailText
                                               textRangeFromPosition:self.detailText.beginningOfDocument
                                               toPosition:self.detailText.endOfDocument]];
    }
    [self.detailText becomeFirstResponder];
    
    return NO;
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
