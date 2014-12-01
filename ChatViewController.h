//
//  ChatViewController.h
//  ParseExample
//
//  Created by Charles Konkol on 10/31/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatTableViewController.h"

@interface ChatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *ChatWindows;
@property (weak, nonatomic) IBOutlet UITextField *SendMessage;
- (IBAction)SendMessage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (strong) NSString *ViewData;
- (IBAction)btnExit:(id)sender;
- (IBAction)SendMsg:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
- (IBAction)btnClearChat:(id)sender;

@end
