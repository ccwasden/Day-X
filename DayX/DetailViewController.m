//
//  DetailViewController.m
//  DayX
//
//  Created by Zack Lounsbury on 9/16/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

static NSString *entryKey = @"entry";
static NSString *titleKey = @"title";
static NSString *textKey = @"text";

@interface DetailViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIButton *clearButton;

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.textField.delegate = self;
    self.textField.placeholder = @"Title";
    
    self.textView.delegate = self;
    
    //self.textView.text = @"Notes...";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textView.layer.borderWidth = 1.0f;
    self.textView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.textView.layer.cornerRadius = 8;
    
    NSMutableDictionary *entry = [[NSUserDefaults standardUserDefaults] valueForKey:entryKey];
    
    [self updateWithDictionary:entry];
    
}

- (IBAction)clearButton:(id)sender {
    
    self.textField.text = @"";
    self.textView.text = @"";
   
}

- (void)updateWithDictionary:(NSDictionary *)dictionary {
    
    NSString *title = [dictionary objectForKey:titleKey];
    
    if (title) {
        self.textField.text = title;
    }
    
    NSString *text = [dictionary objectForKey:textKey];
    
    if (text) {
        self.textView.text = text;
    }
    
}

- (void)save {
    
    NSMutableDictionary *data = [NSMutableDictionary new];
    
    [data setObject:self.textField.text forKey:titleKey];
    [data setObject:self.textView.text forKey:textKey];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:entryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self save];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    [self save];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.textField resignFirstResponder];
    
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
