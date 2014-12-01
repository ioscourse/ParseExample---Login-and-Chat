//
//  ProfileViewController.m
//  pushrvc
//
//  Created by Charles Konkol on 11/28/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

int CountFile;

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    // Do any additional setup after loading the view.
}
-(IBAction) doneEditing:(id) sender {
    [sender resignFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated
{
    
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        self.username.text=[NSString stringWithFormat:@"Welcome, %@", currentUser.username];
        usernames=[NSString stringWithFormat:@"%@", currentUser.username];
   [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(Profile:) userInfo: nil repeats: NO];
     //  [self Profile];

        
    } else {
        // show the signup or login screen
    }

   // self.photo.image = selectedImage;
    
}
-(void)dismissKeyboard {
 [self.txtDescription resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) Profile:(NSTimer*) t
{
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    [query whereKey:@"username" equalTo:usernames];
    NSArray *results = [query findObjects:nil];
    if ([results count] ==0)
    {
        CountFile=0;
    }
    else{
        CountFile=1;
    }
     NSLog(@"Results: %lu",(unsigned long)[results count]);
    [self CreateProfile];
}
- (void) CreateProfile
{
    if (CountFile==0)
    {
      
        PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:UIImagePNGRepresentation(self.photo.image)];
        PFObject *Profile = [PFObject objectWithClassName:@"Profile"];
        Profile[@"username"] = usernames;
        [Profile setObject:imageFile forKey:@"imageFile"];
        Profile[@"description"] = @"Fill In Description";
        [Profile saveInBackground];
        self.txtDescription.text = @"Fill In Description";
    }
    else
    {
  //      PFImageView *imageV;
        PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
        [query whereKey:@"username" matchesRegex:usernames];
        NSArray *results = [query findObjects:nil];
        
                for (PFObject *object in results) {
                    PFFile *imageFile = [object objectForKey:@"imageFile"];
                    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        if (!error) {
                            UIImage *image = [UIImage imageWithData:data];
                            self.photo.image=image;
                        }
                    }];

                    self.txtDescription.text = [object objectForKey:@"description"];
                }
            }
    
   
   

}   
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnChangeImage:(id)sender {
}
- (IBAction)btnUpdateDesc:(id)sender {
    // Update AppUsers
    PFQuery *query = [PFQuery queryWithClassName:@"Profile"];
    [query whereKey:@"username" equalTo:usernames];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)  {
        if (!error) {
            // Found UserStats
            for (PFObject *object in results) {
                [object setObject:self.txtDescription.text forKey:@"description"];
                // Save
                [object saveInBackground];
                
            }
            
        } else {
            // Did not find any UserStats for the current user
            NSLog(@"Error: %@", error);
        }
    }];

}

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGPoint scrollPoint = CGPointMake(0, textField.frame.origin.y);
    [self.scrollview setContentOffset:scrollPoint animated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.scrollview setContentOffset:CGPointZero animated:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    CGPoint scrollPoint = CGPointMake(0, textView.frame.origin.y);
    [self.scrollview setContentOffset:scrollPoint animated:YES];
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [self.scrollview setContentOffset:CGPointZero animated:YES];
}
@end
