//
//  DetailViewController.h
//  AddContact
//
//  Created by Deepak on 29/03/14.
//  Copyright (c) 2014 Deepak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
- (IBAction)xyzToMasetView:(UIStoryboardSegue *)unwindSegue;

@property (strong, nonatomic) User *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailPhoneNumberLabel;
@end
