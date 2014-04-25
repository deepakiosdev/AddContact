//
//  UserProfileViewController.m
//  AddContact
//
//  Created by Deepak on 29/03/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import "UserProfileViewController.h"
#import "PhoneNumber.h"

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextView *dynamicTextView;
@property (weak, nonatomic) IBOutlet UILabel *dynamicTextTabel;

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
    
    
    
    NSString *labelString = @"Ankhen to pyar me dilki zuban hoti hai,sachi chahat to sada bezuban hoti hai, pyar mai dard bhi mile to kya gabrana, suna hai dard se chahat aur jawan hoti hai…. ";
    self.dynamicTextTabel.text = labelString;
    self.dynamicTextTabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self.dynamicTextTabel sizeToFit];
    
    self.dynamicTextView.text = labelString;
    self.dynamicTextView.delegate = self;

    self.dynamicTextView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    NSLog(@"frame--:%@",NSStringFromCGRect(self.dynamicTextTabel.frame));
/*
    //Calculate the expected size based on the font and linebreak mode of your label
    // FLT_MAX here simply means no constraint in height

    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);

    CGSize expectedLabelSize;
    //Return the calculated size of the Label
    expectedLabelSize = [labelString boundingRectWithSize:maximumLabelSize
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{
                                                           NSFontAttributeName : self.dynamicTextTabel.font
                                                           }
                                                 context:nil].size;
    
    //adjust the label the the new height.
    CGRect newFrame = self.dynamicTextTabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.dynamicTextTabel.frame = newFrame;
	// Do any additional setup after loading the view.*/
    NSLog(@"frame--:%@",NSStringFromCGRect(self.dynamicTextTabel.frame));
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

    if (textField == self.phTextField)
    {
        if (![PhoneNumber validPhoneNumber:self.phTextField.text]) {
           // self.phTextField.text = @"Invalid Phone";
            [self.phTextField resignFirstResponder];
        }
    }


}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phTextField)
    {
        [PhoneNumber formatPhoneNumberInTextField:textField changingCharactersInRange:range withString:string];
        return NO;
    }
    return YES;
}

@end
