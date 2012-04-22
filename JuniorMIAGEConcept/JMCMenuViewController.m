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

#define BG_COLOR [UIColor colorWithRed:(49.0/255.0) green:(57.0/255.0) blue:(74.0/255.0) alpha:1.0]
#define TITLE_CELL_COLOR [UIColor colorWithRed:(194.0/255.0) green:(204.0/255.0) blue:(218.0/255.0) alpha:1.0]

#define SECTION_HEADER_HEIGHT 20;


@interface JMCMenuViewController ()

@property (retain, nonatomic) NSArray *sections;
@property (retain, nonatomic) NSMutableDictionary *menu;
@property (retain, nonatomic) NSMutableArray *categories;

@end

@implementation JMCMenuViewController

@synthesize sections = _sections;
@synthesize menu = _menu;
@synthesize categories = _categories;

- (void) dealloc
{
    [_sections release];
    [_menu release];
    [super dealloc];
}

- (NSArray *) sections
{
    if(!_sections)
    {
        _sections = [[NSArray arrayWithObjects:@"Général", @"Catégorie", @"Autres", nil] retain];
    }
    
    return _sections;
}

#pragma mark -
#pragma mark KVO support

- (void)insertCategories:(NSArray *)someCategories 
{
    // this will allow us as an observer to notified (see observeValueForKeyPath)
    // so we can update our UITableView
    //
    
    //    NSLog(@"InsertJMCNews - JMCNewsTableViewController - %d", JMCNews.count);
    //    NSLog(@"Debug : %@",JMCNews.debugDescription);
    [self willChangeValueForKey:@"categories"];
    NSLog(@"Ajout des %d categories", someCategories.count);
    [self.categories addObjectsFromArray:someCategories];
    
    [self didChangeValueForKey:@"categories"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"observeValueForKeyPath - JMCNewsTableViewController");
    [self.tableView reloadData];
}
- (NSMutableDictionary *) menu
{
    if (!_menu)
    {
        NSArray *geneMenu = [NSArray arrayWithObjects:@"All", @"New", nil];
        NSArray *categoryMenu = [NSArray arrayWithObjects:@"CNJE", @"UNS", @"JMC", @"MIAGE", nil];
        
        _menu = [[NSMutableDictionary dictionaryWithObjectsAndKeys:geneMenu, [self.sections objectAtIndex:0], categoryMenu, [self.sections objectAtIndex:1],nil] retain];
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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 30;
    self.tableView.sectionHeaderHeight = SECTION_HEADER_HEIGHT;
    self.tableView.backgroundColor = BG_COLOR;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
	// create the parent view that will hold header Label

	JMCMenuHeaderSectionView *headerSectionView = [[[JMCMenuHeaderSectionView alloc] initWithFrame:CGRectZero] autorelease];
    headerSectionView.sectionTitle.text = [self.sections objectAtIndex:section];// TODO Mettre nom de la section
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
    
    static NSString *CellIdentifier = @"menuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.backgroundView =[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menuCell.png"]]autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:13];
        cell.textLabel.textColor = TITLE_CELL_COLOR;
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
