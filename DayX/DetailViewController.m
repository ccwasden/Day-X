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
@property (assign, nonatomic) NSInteger buttonTag;

@property (strong, nonatomic) UIBarButtonItem *doneButton;
@property (strong, nonatomic) UIBarButtonItem *settingsButton;

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
    
    self.detailTitle.delegate = self;
    self.detailText.delegate = self;
    
    self.view.backgroundColor = [UIColor whiteColor];
    _buttonTag = 0;
    
    _doneButton = [UIBarButtonItem new];
    _doneButton.title = @"Done";
    _doneButton.target = self;
    _doneButton.action = @selector(done);
    
    //_settingsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(settings)];
    self.navigationItem.rightBarButtonItem = _doneButton;
    
    // Set up Title if entry properties exist
    if (self.detailEntry.title != nil) {
        self.title = self.detailEntry.title;
        self.detailTitle.text = self.detailEntry.title;
        
    }
    else {
        self.detailTitle.placeholder = @"Title";
        self.navigationItem.title = @"New Note";
    }
    
    // Set up Body text if entry properties exist
    if (self.detailEntry.text != nil) {
        self.detailText.text = self.detailEntry.text;
    }
    else {
        [self.detailText becomeFirstResponder];
    }
    
    
    
    self.buttons = @[self.button0, self.button1, self.button2, self.button3];
    // Set up Color if entry properties exit;
    if (self.detailEntry.color != nil && self.detailEntry.color != [UIColor whiteColor]) {
        //self.view.backgroundColor = self.detailEntry.color;
        
        UIButton* temp1Button = [UIButton new];
        temp1Button.backgroundColor = self.detailEntry.color;
        [self changeColor:temp1Button];
        
        // This doesn't work...
        /*
        for (UIButton *tempButton in self.buttons) {
            
            if (tempButton.backgroundColor == self.detailEntry.color) {
                [self changeColor:tempButton];
            }
        }
        */
    }
    
    /*
    CGFloat height = _button0.frame.size.height + (CGFloat)10;
    CGFloat width = self.view.frame.size.width * 2;
    
    
    UIScrollView *scrollMenu = [[UIScrollView alloc] initWithFrame:
                                CGRectMake(0, self.view.frame.size.height - height, width, height)];
    [scrollMenu addSubview:_button0];
    [scrollMenu addSubview:_button1];
    [scrollMenu addSubview:_button2];
    [scrollMenu addSubview:_button3];
    
    scrollMenu.backgroundColor = [UIColor blackColor];

    [self.view addSubview:scrollMenu];
    */
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(swipeColorRight:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action:@selector(swipeColorLeft:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swipeLeft];
    
}

- (void)swipeColorRight:(UISwipeGestureRecognizer *)gesture {
    
    for (int i = 0; i <= _buttons.count; i++) {
        
        if (i == _buttonTag) {
            
            UIButton* temp = [UIButton new];
            
            if (i == 0) {
                temp.backgroundColor = [UIColor whiteColor];
                temp.tag = -2;
            }
            else {
                
                temp = _buttons[_buttonTag - 1];
            }
            
            [self changeColor:temp];
            return;
            
        }
    }

    
}

- (void)swipeColorLeft:(UISwipeGestureRecognizer *)gesture {
    
    for (int i = 0; i <= _buttons.count; i++) {
        
        if (i == _buttonTag) {
            
            UIButton* temp = [UIButton new];
            
            if (i == _buttons.count) {
                temp.backgroundColor = [UIColor whiteColor];
                temp.tag = -1;
            }
            else {
                
                temp = _buttons[_buttonTag];
            }
            
            [self changeColor:temp];
            return;
            
        }
    }
  
}

- (void)done {
    
    [self.detailText resignFirstResponder];
    [self.detailTitle resignFirstResponder];
}


- (IBAction)changeColor:(UIButton*)sender {
    
    UIColor *backColor = [UIColor new];
    UIColor *textColor = [UIColor new];
    
    if ([sender backgroundColor] == [UIColor whiteColor]) {
        
        if (sender.tag == -1) {
            
            UIButton *temp = _buttons[3];
            temp.backgroundColor = self.view.backgroundColor;
        }
        else {
            sender.backgroundColor = self.buttonColor;
        }
        
        self.buttonTag = 0;
        
        backColor = [UIColor whiteColor];
        textColor = [UIColor darkTextColor];
    }
    else {
        
        if (self.view.backgroundColor != [UIColor whiteColor]) {
            
            for (UIButton *button in self.buttons) {
                
                if (button.backgroundColor == [UIColor whiteColor]) {
                    button.backgroundColor = self.buttonColor;
                    break;
                }
            }
    
        }
        
        self.buttonColor = [sender backgroundColor];
        self.buttonTag = [sender tag];
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
    
    return YES;
}


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    _doneButton.title = @"Done";
    
    return YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    _doneButton.title = @"";
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [self save];
}

- (void)save {
    
    ESEntry *newEntry = [ESEntry new];
    newEntry.title = self.detailTitle.text;
    newEntry.text = self.detailText.text;
    newEntry.color = self.view.backgroundColor;
    
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
