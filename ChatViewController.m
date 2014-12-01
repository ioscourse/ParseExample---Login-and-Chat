//
//  ChatViewController.m
//  ParseExample
//
//  Created by Charles Konkol on 10/31/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

int x=0;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.ChatWindows.layoutManager.allowsNonContiguousLayout = NO;
    self.ChatWindows.text=@"";
   
   
    //self.ChatWindows.text = self.ViewData;
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        self.UserName.text=[NSString stringWithFormat:@"Welcome, %@", currentUser.username];
        usernames=[NSString stringWithFormat:@"%@", currentUser.username];
        [NSTimer scheduledTimerWithTimeInterval: 1.0  target: self selector: @selector(GetchatMsg:) userInfo: nil repeats: YES];

    } else {
        // show the signup or login screen
    }
   
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

    [self.SendMessage becomeFirstResponder];
  
    
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

- (IBAction)SendMessage:(id)sender {
    // Send a notification to all devices subscribed to the "Giants" channel.
  }
- (IBAction)btnExit:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) scrollToBottom {

    NSRange bottom = NSMakeRange(self.ChatWindows.text.length+17, 1);
    [self.ChatWindows scrollRangeToVisible:bottom];
 }
- (void)textViewDidChangeSelection:(UITextView *)textView {
    [textView scrollRangeToVisible:textView.selectedRange];
  
}

- (void)textViewDidChange:(UITextView *)textView {

    CGRect line = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = line.origin.y + line.size.height -
    (textView.contentOffset.y +
     textView.bounds.size.height -
     textView.contentInset.bottom -
     textView.contentInset.top );
    if ( overflow > 0 )
    {
        // We are at the bottom of the visible text and introduced
        // a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated:
        // or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}
- (void) GetchatMsgs
{
    PFQuery *Receiverquery = [PFQuery queryWithClassName:@"Chats"];
    [Receiverquery whereKey:@"receiver" equalTo:self.ViewData];
    PFQuery *Senderquery = [PFQuery queryWithClassName:@"Chats"];
    [Senderquery whereKey:@"sender" equalTo:usernames];
    PFQuery *Receiverquery2 = [PFQuery queryWithClassName:@"Chats"];
    [Receiverquery2 whereKey:@"receiver" equalTo:usernames];
    PFQuery *Senderquery2 = [PFQuery queryWithClassName:@"Chats"];
    [Senderquery2 whereKey:@"sender" equalTo:self.ViewData];
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[Receiverquery,Senderquery,Receiverquery2,Senderquery2]];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.ChatWindows.text=@"";
            for (PFObject *object in objects) {
                self.ChatWindows.text=[NSString stringWithFormat:@"%@\n%@", self.ChatWindows.text, [object objectForKey:@"message"]];
                [self scrollToBottom];

            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}
- (void) DeletetMsgs
{
    PFQuery *Receiverquery = [PFQuery queryWithClassName:@"Chats"];
    [Receiverquery whereKey:@"receiver" equalTo:self.ViewData];
    PFQuery *Senderquery = [PFQuery queryWithClassName:@"Chats"];
    [Senderquery whereKey:@"sender" equalTo:usernames];
    PFQuery *Receiverquery2 = [PFQuery queryWithClassName:@"Chats"];
    [Receiverquery2 whereKey:@"receiver" equalTo:usernames];
    PFQuery *Senderquery2 = [PFQuery queryWithClassName:@"Chats"];
    [Senderquery2 whereKey:@"sender" equalTo:self.ViewData];
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[Receiverquery,Senderquery,Receiverquery2,Senderquery2]];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.ChatWindows.text=@"";
            for (PFObject *object in objects) {
                  [object deleteInBackground];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
    
}



- (void) GetchatMsg:(NSTimer*) t
{
    [self GetchatMsgs];
}
- (IBAction)SendMsg:(id)sender {
   
    PFObject *chat = [PFObject objectWithClassName:@"Chats"];
    chat[@"sender"] = usernames;
    chat[@"receiver"] = self.ViewData;
    chat[@"message"] = [NSString stringWithFormat:@"%@: %@", usernames,self.SendMessage.text];;
    [chat saveInBackground];
    self.SendMessage.text=@"";
}

- (IBAction)btnClearChat:(id)sender {
    [self DeletetMsgs];
    self.ChatWindows.text=@"";
}
@end
