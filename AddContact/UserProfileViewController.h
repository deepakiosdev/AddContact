//
//  UserProfileViewController.h
//  AddContact
//
//  Created by Deepak on 29/03/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface UserProfileViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phTextField;
@property (strong, nonatomic) User *user;

@end
