//
//  JMCNewsViewController.m
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 20/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCNewsViewController.h"
#define BG_COLOR [UIColor colorWithRed:(216.0/255.0) green:(216.0/255.0) blue:(216.0/255.0) alpha:1.0]

#define SUBTITLE_COLOR [UIColor colorWithRed:(147.0/255.0) green:(144.0/255.0) blue:(144.0/255.0) alpha:1.0]

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
    self.view.backgroundColor = BG_COLOR;
    
    //Configuration du titre
    self.newsTitle.text = self.jmcNews.title;
    
    //Configuration du sous-titre
    self.newsSubTitle.textColor= SUBTITLE_COLOR;
    self.newsSubTitle.text = [NSString stringWithFormat:@"%@ - %@", self.jmcNews.author, self.jmcNews.pubDate];
    
    NSString* strHtml = [NSString stringWithFormat:@"<html><head><link href='style.css' rel='stylesheet' type='text/css' /></head><body>%@</body></html>",self.jmcNews.content];
    
    NSLog(@"Content : %@", self.jmcNews.content);

    
    [self.newsContent loadHTMLString:strHtml baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    self.newsContent.backgroundColor = [UIColor clearColor];
    self.newsContent.opaque = NO;

    
    // Set the back button
    UIButton *backButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)]autorelease];//Create a view with "backButton" UIImage size
    [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *backButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:backButton] autorelease];
    self.navigationItem.leftBarButtonItem = backButtonItem;//on remplace le bouton en haut à gauche

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
