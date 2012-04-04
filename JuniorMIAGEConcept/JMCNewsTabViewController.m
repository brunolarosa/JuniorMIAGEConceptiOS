//
//  JMCNewsTabViewController.m
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCNewsTabViewController.h"

@interface JMCNewsTabViewController ()

@property (nonatomic, retain) NSMutableDictionary *words;
@property (nonatomic, retain) NSArray *sections;

@end

@implementation JMCNewsTabViewController

@synthesize words = _words;
@synthesize sections = _sections;

- (NSMutableDictionary *)words
{
	if (!_words) {
		NSURL *wordsURL = [NSURL URLWithString:@"http://cs193p.stanford.edu/vocabwords.txt"];
		_words = [[NSMutableDictionary dictionaryWithContentsOfURL:wordsURL] retain];
	}
	return _words;
}

- (NSArray *)sections
{
	if (!_sections) {
		_sections = [[[self.words allKeys] sortedArrayUsingSelector:@selector(compare:)] retain];
	}
	return _sections;
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
    
    self.title = @"JMC";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

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

- (NSString *)wordAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray *wordsInSection = [self.words objectForKey:[self.sections objectAtIndex:indexPath.section]];
	return [wordsInSection objectAtIndex:indexPath.row];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *wordsInSection = [self.words objectForKey:[self.sections objectAtIndex:section]];
	return wordsInSection.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsTableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	cell.textLabel.text = [self wordAtIndexPath:indexPath];
    cell.detailTextLabel.text = @"Toto";
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
		NSString *section = [self.sections objectAtIndex:indexPath.section];
		NSMutableArray *wordsInSection = [[self.words objectForKey:section] mutableCopy];
		[wordsInSection removeObjectAtIndex:indexPath.row];
		[self.words setObject:wordsInSection forKey:section];
		[wordsInSection release];
		// Delete the row from the table view
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return [self.sections objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	return self.sections;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark -
#pragma mark Memory management

- (void)dealloc
{
	[_words release];
	[_sections release];
    [super dealloc];
}

@end


