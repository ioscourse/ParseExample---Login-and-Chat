//
//  SelectedPhotoViewController.m
//  pushrvc
//
//  Created by Charles Konkol on 11/29/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import "SelectedPhotoViewController.h"

@interface SelectedPhotoViewController ()

@end

@implementation SelectedPhotoViewController
@synthesize photoImageView, imageName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
   // self.photoImageView.image = selectedImage;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewDidAppear:(BOOL)animated
{
    self.photoImageView.image = selectedImage;

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)btnClose:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

@end
