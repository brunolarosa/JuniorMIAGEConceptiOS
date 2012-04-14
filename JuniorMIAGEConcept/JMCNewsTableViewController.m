//
//  JMCNewsTableViewController.m
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCNewsTableViewController.h"
#import "JMCNewsViewController.h"
#import "JMCNews.h"

@interface JMCNewsTableViewController ()

@end

@implementation JMCNewsTableViewController

@synthesize jmcNewsList = _jmcNewsList;


- (void)addRows {
    JMCNews *entry1 = [[[JMCNews alloc] initWithTitle:@"1"
                                              pubDate:[NSDate date]
                                               author:@"1"
                                             category:@"1"
                                          description:@"1"] autorelease];
    
    JMCNews *entry2 = [[[JMCNews alloc] initWithTitle:@"2"
                                              pubDate:[NSDate date]
                                               author:@"2"
                                             category:@"2"
                                          description:@"2"] autorelease];
    
    JMCNews *entry3 = [[[JMCNews alloc] initWithTitle:@"3"
                                              pubDate:[NSDate date]
                                               author:@"3"
                                             category:@"3"
                                          description:@"3"] autorelease];


    
    [self.jmcNewsList insertObject:entry1 atIndex:0];
    [self.jmcNewsList insertObject:entry2 atIndex:0];
    [self.jmcNewsList insertObject:entry3 atIndex:0];
    NSLog(@"Rows added");
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    NSLog(@"View loaded");
    self.title = @"Feeds";
    
    self.jmcNewsList = [NSMutableArray array];
    [self addRows];
    NSLog(@"%d", [self.jmcNewsList count]);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.jmcNewsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
    JMCNews *entry = [self.jmcNewsList objectAtIndex:indexPath.row];
    
    NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *articleDateString = [dateFormatter stringFromDate:entry.pubDate];
    
    cell.textLabel.text = entry.title;        
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", articleDateString, entry.author];
    
    NSLog(@"Cell recupéré");
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     JMCNewsViewController *detailViewController = [[JMCNewsViewController alloc] init];
    detailViewController.jmcNews = [self.jmcNewsList objectAtIndex:indexPath.row];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

-(void) dealloc
{
    [_jmcNewsList release];
    [super dealloc];
}

@end
