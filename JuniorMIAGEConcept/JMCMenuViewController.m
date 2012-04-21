//
//  JMCMenuViewController.m
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 14/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCMenuViewController.h"
#import "IIViewDeckController.h"
#import "JMCNewsTableViewController.h"
#import "JMCMenuHeaderSectionView.h"


@interface JMCMenuViewController ()

@property (retain, nonatomic) NSArray *sections;
@property (retain, nonatomic) NSMutableDictionary *menu;

@end

@implementation JMCMenuViewController

@synthesize sections = _sections;
@synthesize menu = _menu;

- (NSArray *) sections
{
    if(!_sections)
    {
        _sections = [[NSArray alloc] initWithObjects:@"Général", @"Catégorie", @"Autres", nil];
    }
    
    return _sections;
}

- (NSMutableDictionary *) menu
{
    if (!_menu)
    {
        NSArray *geneMenu = [[NSArray alloc] initWithObjects:@"All", @"New", nil];
        NSArray *categoryMenu = [[NSArray alloc] initWithObjects:@"CNJE", @"UNS", @"JMC", @"MIAGE", nil];
        
        _menu = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:geneMenu, [self.sections objectAtIndex:0], categoryMenu, [self.sections objectAtIndex:1], nil] retain];
    }
    return _menu;
}

- (NSString *)menusAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *menusInSection = [self.menu objectForKey:[self.sections objectAtIndex:indexPath.section]];
	return [menusInSection objectAtIndex:indexPath.row];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        //
        // Change the properties of the imageView and tableView (these could be set
        // in interface builder instead).
        //
        self.tableView.rowHeight = 30;
        self.tableView.backgroundColor = [UIColor colorWithRed:(49.0/255.0)
                                                         green:(57.0/255.0)
                                                          blue:(74.0/255.0)
                                                         alpha:1.0];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect frame = CGRectMake(0, 0, 320, 15);
	// create the parent view that will hold header Label
	JMCMenuHeaderSectionView *headerSectionView = [[[JMCMenuHeaderSectionView alloc] initWithFrame:frame] autorelease];
    headerSectionView.sectionTitle.text = @"CATEGORIES";
   // NSLog(@"%f", headerSectionView.frame.size.height);
	return headerSectionView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *menuInSection = [self.menu objectForKey:[self.sections objectAtIndex:section]];
	return menuInSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuCell.png"]]autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.textLabel.textColor = [UIColor colorWithRed:(194.0/255.0)
                                                   green:(204.0/255.0)
                                                    blue:(218.0/255.0)
                                                   alpha:1.0];
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.shadowOffset = CGSizeMake(0, 1);
    }
    // Configure the cell...
    
    cell.textLabel.text = [self menusAtIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:@"iconNew.png"]; 
    
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.sections objectAtIndex:section];
}

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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller)
     {
         if ([controller.centerController isKindOfClass:[UINavigationController class]])
         {
             JMCNewsTableViewController *jmcNewsTableController = (JMCNewsTableViewController *)((UINavigationController *)controller.centerController).topViewController;
             
             jmcNewsTableController.navigationItem.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
         }
     }];
}

@end
