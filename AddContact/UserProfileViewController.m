//
//  UserProfileViewController.m
//  AddContact
//
//  Created by Deepak on 29/03/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.user = [User new];
    self.user.name = @"deepak";
    self.user.phone = @"8602875253";
    NSLog(@"name:%@,phone:%@",self.user.name, self.user.phone);

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTapped:(id)sender {
   //[self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"name:%@,phone:%@",self.nameTextField.text, self.phTextField.text);
    NSLog(@"name:%@,phone:%@",self.user.name, self.user.phone);

    [self.nameTextField resignFirstResponder];
    [self.phTextField resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];

    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSLog(@"sourceViewController:%@, destinationViewController:%@ ",[segue sourceViewController], [segue destinationViewController] );

    } else if ([[segue identifier] isEqualToString:@"showUserProfile"])
    {
        NSLog(@"sourceViewController:%@, destinationViewController:%@ ",[segue sourceViewController], [segue destinationViewController] );
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    
    if (textField == self.nameTextField) {
        //self.user.name = textField.text;
        self.nameTextField = textField;
    }
    if (textField == self.phTextField) {
        //self.user.phone = textField.text;
        self.phTextField = textField;

    }
    NSLog(@"name:%@,phone:%@",self.user.name, self.user.phone);
}

- (void)textFieldDidEndEditing:(UITextField *)textField            // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{



}

@end
