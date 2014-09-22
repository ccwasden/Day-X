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
@property (strong, nonatomic) UIColor *buttonColor;

@property (strong, nonatomic) IBOutlet UITextField *detailTitle;
@property (strong, nonatomic) IBOutlet UITextView *detailText;
@property (strong, nonatomic) IBOutlet UILabel *detailSpacer;
@property (strong, nonatomic) IBOutlet UILabel *detailSpacer2;

@property (strong, nonatomic) NSArray *buttons;
@property (strong, nonatomic) IBOutlet UIButton *button0;
@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;


@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.buttons = @[self.button0, self.button1, self.button2, self.button3];
    
    self.detailTitle.delegate = self;
    self.detailText.delegate = self;

    
    UIBarButtonItem *doneButton = [UIBarButtonItem new];
    doneButton.title = @"Done";
    doneButton.target = self;
    doneButton.action = @selector(doneButton);
    self.navigationItem.rightBarButtonItem = doneButton;
    
    // Set up Title if entry properties exist
    if (self.detailEntry.title != nil) {
        self.title = self.detailEntry.title;
        self.detailTitle.text = self.detailEntry.title;
        
    }
    else {
        self.detailTitle.placeholder = @"Title";
    }
    
    // Set up Body text if entry properties exist
    if (self.detailEntry.text != nil) {
        self.detailText.text = self.detailEntry.text;
    }
    else {
        //self.detailText.textColor = [UIColor lightGrayColor];
        self.detailText.text = @"Notes...";
    }
    
    // Set up Color if entry properties exit;
    if (self.detailEntry.color != nil) {
        self.view.backgroundColor = self.detailEntry.color;
        
        for (UIButton *button in self.buttons) {
            if (button.backgroundColor == self.detailEntry.color) {
                button.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    

    // Set which items will be editable first
    if ([self.detailText.text isEqual:@"Notes..."]){
        [self.detailText setSelectedTextRange:[self.detailText
                                               textRangeFromPosition:self.detailText.beginningOfDocument
                                               toPosition:self.detailText.endOfDocument]];
        [self.detailText becomeFirstResponder];
    }
    
    
}

-(void)doneButton {
    
    [self.detailText resignFirstResponder];
    [self.detailTitle resignFirstResponder];
}


- (IBAction)changeColor:(UIButton*)sender {
    
    UIColor *backColor = [UIColor new];
    UIColor *textColor = [UIColor new];
    
    if ([sender backgroundColor] == [UIColor whiteColor]) {
        
        sender.backgroundColor = self.buttonColor;
        backColor = [UIColor whiteColor];
        textColor = [UIColor darkTextColor];
    }
    else {
        
        if (self.view.backgroundColor != [UIColor whiteColor]) {
            
            for (UIButton *button in self.buttons) {
                
                if (button.backgroundColor == [UIColor whiteColor]) {
                    button.backgroundColor = self.buttonColor;
                }
            }
    
        }
        
        self.buttonColor = [sender backgroundColor];
        backColor = [sender backgroundColor];
        textColor = [UIColor whiteColor];
        sender.backgroundColor = [UIColor whiteColor];
        
        
    }
    
    self.view.backgroundColor = backColor;
    self.detailTitle.backgroundColor = backColor;
    self.detailTitle.textColor = textColor;
    self.detailText.backgroundColor = backColor;
    self.detailText.textColor = textColor;
    self.detailSpacer.backgroundColor = textColor;
    self.detailSpacer2.backgroundColor = textColor;
}


- (void)updateEntry:(ESEntry *)entry {
    
    self.detailEntry = entry;
}

-(void)textFieldDidEndEditing:(UITextField *)textField  {
    
    self.title = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.detailTitle resignFirstResponder];
    
    return NO;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if ([textView.text isEqual:@""]) {
        textView.text = @"Notes...";
    }
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
