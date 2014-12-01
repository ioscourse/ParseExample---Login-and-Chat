//
//  SelectedPhotoViewController.h
//  pushrvc
//
//  Created by Charles Konkol on 11/29/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedPhotoViewController : UIViewController
{
        IBOutlet UIImageView *photoImageView;

    NSString *imageName;
}


@property (nonatomic, retain) NSString *imageName;


- (IBAction)btnClose:(id)sender;
@property (nonatomic, retain) IBOutlet UIImageView *photoImageView;

@end
