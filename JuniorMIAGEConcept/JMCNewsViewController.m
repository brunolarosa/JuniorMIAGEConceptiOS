//
//  JMCNewsViewController.m
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 20/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCNewsViewController.h"

@interface JMCNewsViewController ()

@end

@implementation JMCNewsViewController

@synthesize jmcNews = _jmcNews;
@synthesize newsTitle = _newsTitle;
@synthesize newsSubTitle = _newsSubTitle;
@synthesize newsContent = _newsContent;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    
    return self;
}

-(void)popViewController {
    //fonction de retour à la vue précédente
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.newsTitle.text = self.jmcNews.title;
    self.newsSubTitle.text = [NSString stringWithFormat:@"%@ - %@", self.jmcNews.author, self.jmcNews.pubDate];
    self.newsContent.text = self.jmcNews.description;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton.png"] style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    
    [[self navigationItem] setBackBarButtonItem:backButton]; 
    /*
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];//tes dimensions de l'image
    [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchDown];//il faudra définir une fonction de retour
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;//on remplace le bouton en haut à gauche*/


    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setNewsTitle:nil];
    [self setNewsSubTitle:nil];
    [self setNewsContent:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_newsTitle release];
    [_newsSubTitle release];
    [_newsContent release];
    [super dealloc];
}
@end
