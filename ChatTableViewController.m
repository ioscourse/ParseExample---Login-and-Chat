//
//  ChatTableViewController.m
//  ParseExample
//
//  Created by Charles Konkol on 10/31/14.
//  Copyright (c) 2014 Rock Valley College. All rights reserved.
//

#import "ChatTableViewController.h"
#import "ChatViewController.h"

@interface ChatTableViewController ()

@end

@implementation ChatTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if([self checkinternet] == NO)
    {
        // Not connected to the internet
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Internet Connection Required"
                                                          message:@"Close app and return when internet connection available."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
    else
    {
        self = [super initWithCoder:aDecoder];
        if (self) {
            // Custom the table
            
            // The className to query on
            self.parseClassName = @"_User";
            
            // The key of the PFObject to display in the label of the default cell style
            self.textKey = @"username";
            
            // The title for this table in the Navigation Controller.
            self.title = @"Members";
            
            // Whether the built-in pull-to-refresh is enabled
            self.pullToRefreshEnabled = YES;
            
            // Whether the built-in pagination is enabled
            self.paginationEnabled = YES;
            
            // The number of objects to show per page
            self.objectsPerPage = 5;
        }
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

// Override to customize what kind of query to perform on the class. The default is to query for
// all objects ordered by createdAt descending.



- (PFQuery *)queryForTable {
 
    NSString *pred = [NSString stringWithFormat:@"username <>%@%@%@",@"'",usernames,@"'"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: pred];
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName  predicate:predicate];
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if ([self.objects count] == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query orderByDescending:@"username"];
    
    return query;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell

   cell.textLabel.text = [object objectForKey:@"username"];
  
   
  //  cell.detailTextLabel.text = [object objectForKey:@"CreatedAt"];
    return cell;
}


- (IBAction)btnBack:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL) checkinternet
{
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com/m"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    if (data)
    {
        NSLog(@"Device is connected to the internet");
        return YES;
    }
    else
    {
        NSLog(@"Device is not connected to the internet");
        return NO;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Admin"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        NSString *selectedDevice =  [object objectForKey:@"username"];
        ChatViewController *destViewController = segue.destinationViewController;
        // When users indicate they are Giants fans, we subscribe them to that channel.
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        [currentInstallation addUniqueObject:selectedDevice forKey:@"channels"];
        [currentInstallation saveInBackground];
        destViewController.ViewData=selectedDevice;
        
    }
}
@end
