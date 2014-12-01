//
//  ProfileViewController.h
//  pushrvc
//
//  Created by Charles Konkol on 11/28/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#include <stdlib.h>
#include <AppDelegate.h>

@interface ProfileViewController : UIViewController
{
    NSString *imageName;
}
@property (weak, nonatomic) IBOutlet UILabel *lblprofile;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)btnChangeImage:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;
- (IBAction)btnUpdateDesc:(id)sender;
- (IBAction)btnBack:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *username;
-(IBAction) doneEditing:(id) sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
