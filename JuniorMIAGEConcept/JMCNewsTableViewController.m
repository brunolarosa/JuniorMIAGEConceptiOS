//
//  JMCNewsTableViewController.m
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//
#import "IIViewDeckController.h"

#import "JMCNewsTableViewController.h"
#import "JMCNews.h"
#import "JMCNewsCell.h"
#import "JMCNewsViewController.h"
#import "JMCAppDelegate.h"



#define BG_COLOR [UIColor colorWithRed:(216.0/255.0) green:(216.0/255.0) blue:(216.0/255.0) alpha:1.0]

@interface JMCNewsTableViewController ()
@end

@implementation JMCNewsTableViewController

@synthesize jmcNewsList;
@synthesize selectedCategory;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.navigationItem.backBarButtonItem.title = @"";
        
        
        self.tableView.rowHeight = 80;
        self.tableView.backgroundColor = BG_COLOR;
    }
    return self;
}

-(void) setSelectedCategory:(NSString *)aSelectedCategory{
    
    if(aSelectedCategory == @"All"){
        selectedCategory = nil;
    } else {
         selectedCategory = aSelectedCategory;
    }
   
    [self.tableView reloadData];
}

- (void) menuPressed
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

- (void) refreshPressed
{
    JMCAppDelegate *delegate = (JMCAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate loadRssFeed];
}

- (void)viewDidLoad
{    
    [super viewDidLoad]; 
    
    self.navigationItem.title = @"RSSFeeds";
    self.jmcNewsList = [NSMutableArray array];
    [self addObserver:self forKeyPath:@"JMCNewsList" options:0 context:NULL];
    
    //[self addRows];
    //NSLog(@"%d", [self.JMCNewsList count]);

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Set Menu Button
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)] autorelease];//tes dimensions de l'image
    [backButton setImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(menuPressed) forControlEvents:UIControlEventTouchDown];//il faudra définir une fonction de retour
    UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    
    
    //Set Refresh Button
    UIButton *refreshButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)] autorelease];//tes dimensions de l'image
    [refreshButton setImage:[UIImage imageNamed:@"refresh.png"] forState:UIControlStateNormal];
    [refreshButton addTarget:self action:@selector(refreshPressed) forControlEvents:UIControlEventTouchDown];//il faudra définir une fonction de retour
    UIBarButtonItem *refreshButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:refreshButton] autorelease];
    self.navigationItem.rightBarButtonItem = refreshButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.jmcNewsList = nil;
    
    [self removeObserver:self forKeyPath:@"JMCNewsList"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

#pragma mark -
#pragma mark KVO support

- (void)insertJMCNews:(NSArray *)aJMCNews
{
    // this will allow us as an observer to notified (see observeValueForKeyPath)
    // so we can update our UITableView
    
    [self willChangeValueForKey:@"JMCNewsList"];
    NSLog(@"Ajout des %d articles", aJMCNews.count);
    [self.jmcNewsList addObjectsFromArray:aJMCNews];
    
    [self didChangeValueForKey:@"JMCNewsList"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
//    NSLog(@"observeValueForKeyPath - JMCNewsTableViewController");
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if(selectedCategory != nil){
        for(JMCNews *object in jmcNewsList){
                if([object.category containsObject:selectedCategory]){
                    count++;   
                }
            
        }
    } else {
        count = [jmcNewsList count];
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;

}

/*
- (UITableViewCell *)getTextCellWithTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
	static NSString *TextCellIdentifier = @"TextCell";
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TextCellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TextCellIdentifier] autorelease];
    }
    JMCNews *entry = [self.jmcNewsList objectAtIndex:((indexPath.row-1)/2)];
	
	//article preview
	cell.textLabel.font = [UIFont systemFontOfSize:11];
	cell.textLabel.numberOfLines = 3;
	cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
	cell.backgroundColor = [UIColor clearColor];
	cell.textLabel.backgroundColor = [UIColor clearColor];
    
	UIView *backView = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
	backView.backgroundColor = [UIColor clearColor];
	cell.backgroundView = backView;
	
	CGRect f = cell.textLabel.frame;
	[cell.textLabel setFrame: CGRectMake(f.origin.x+15, f.origin.y, f.size.width-15, f.size.height)];
	cell.textLabel.text = entry.description;
	
	return cell;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"menuCell";
    
    JMCNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[JMCNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell...
    JMCNews *entry;
    if(selectedCategory == nil)
    {
        entry = [self.jmcNewsList objectAtIndex: indexPath.section];
    }
    else
    {
        NSInteger count=0;
        
        NSEnumerator *e = [jmcNewsList objectEnumerator];
        JMCNews *buf;
        while (count != (indexPath.section+1) && (buf = [e nextObject])) {
            // do something with object
            if([buf.category containsObject:selectedCategory]){
                count++;
                entry = buf;
            }
        }
    }

    cell.titleLabel.text = entry.title;
    cell.resumeLabel.text = entry.description;
    cell.footerLabel.text = [NSString stringWithFormat:@"%@ - %@ ", entry.author, entry.pubDate];
    cell.commentsLabel.text = @"99";
//    NSLog(@"%@", entry.author);
    
    
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
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    JMCNews *entry = [self.jmcNewsList objectAtIndex: indexPath.section];
    
    JMCNewsViewController *newsViewController = [[JMCNewsViewController alloc] initWithNibName:@"JMCNewsViewController" bundle:nil];
    newsViewController.jmcNews = entry;
    
    [self.navigationController pushViewController:newsViewController animated:YES];
    [newsViewController release];
    
}

-(void) dealloc
{
    [jmcNewsList release];
    [super dealloc];
}

@end
