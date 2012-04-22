//
//  JMCAppDelegate.m
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCAppDelegate.h"
#import "JMCNewsTableViewController.h"
#import "JMCMenuViewController.h"
#import "IIViewDeckController.h"
#import "JMCParseOperation.h"

// this framework was imported so we could use the kCFURLErrorNotConnectedToInternet error code
#import <CFNetwork/CFNetwork.h>

#pragma mark JMCAppDelegate () 

// forward declarations
@interface JMCAppDelegate ()

@property (nonatomic, retain) NSURLConnection *JMCNewsFeedConnection;
@property (nonatomic, retain) NSMutableData *JMCNewsData;    // the data returned from the NSURLConnection
@property (nonatomic, retain) NSOperationQueue *parseQueue;     // the queue that manages our NSOperation for parsing JMCNews data(n

@property (nonatomic, retain) JMCNewsTableViewController *newsTabView;
@property (nonatomic, retain) JMCMenuViewController *menuTabView;

- (void)addJMCNewsToList:(NSArray *)news;
- (void)addCategoriesToList:(NSArray *)categories;
- (void)handleError:(NSError *)error;
@end


@implementation JMCAppDelegate

@synthesize window = _window;
@synthesize JMCNewsFeedConnection;
@synthesize JMCNewsData;
@synthesize parseQueue;
@synthesize leftViewController = _leftViewController;
@synthesize centerViewController = _centerViewController;
@synthesize newsTabView;
@synthesize menuTabView;


- (void)dealloc
{

    [JMCNewsFeedConnection cancel];
    [JMCNewsFeedConnection release];
    
    [JMCNewsData release];    
    [parseQueue release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddJMCNewsNotif object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kJMCNewsErrorNotif object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kAddCategoriesNotif object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kCategoriesErrorNotif object:nil];
    

    [_centerViewController release];
    [_leftViewController release];

    [_window release];
    [super dealloc];
}

- (void) customizeNavBar
{
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBar.png"]
                                       forBarMetrics:UIBarMetricsDefault];
    
    //Set the title appearance for *all* UINavigationBars
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0], 
      UITextAttributeTextColor, 
      [UIColor clearColor], 
      UITextAttributeTextShadowColor, 
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], 
      UITextAttributeTextShadowOffset, 
      [UIFont fontWithName:@"Arial-Bold" size:0.0], 
      UITextAttributeFont, 
      nil]];
    
    
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self customizeNavBar];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] retain];
    

    static NSString *feedURLString = @"http://www.juniormiageconcept.com/clients/?feed=rss2";
    NSURLRequest *JMCNewsURLRequest =
    [NSURLRequest requestWithURL:[NSURL URLWithString:feedURLString]];
    self.JMCNewsFeedConnection =
    [[[NSURLConnection alloc] initWithRequest:JMCNewsURLRequest delegate:self] autorelease];
    
     NSAssert(self.JMCNewsFeedConnection != nil, @"Failure to create URL connection.");
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    parseQueue = [NSOperationQueue new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addJMCNews:)
                                                 name:kAddJMCNewsNotif
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(JMCNewsError:)
                                                 name:kJMCNewsErrorNotif
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addCatgories:)
                                                 name:kAddJMCNewsNotif
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addCategoriesError:)
                                                 name:kJMCNewsErrorNotif
                                               object:nil];
    
    newsTabView = [[[JMCNewsTableViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    self.centerViewController = [[[UINavigationController alloc]initWithRootViewController:newsTabView] retain];

    

    menuTabView = [[[JMCMenuViewController alloc] init] retain];
    self.leftViewController = menuTabView;
    
   
    IIViewDeckController *deck = [[[IIViewDeckController alloc] initWithCenterViewController:self.centerViewController
                                                                          leftViewController:self.leftViewController] autorelease];
    deck.leftLedge = 160;
    
    self.window.rootViewController = deck; //TODO: remettre tabController
    [self.window makeKeyAndVisible];
    return YES;
}


// The following are delegate methods for NSURLConnection. Similar to callback functions, this is
// how the connection object, which is working in the background, can asynchronously communicate back
// to its delegate on the thread from which it was started - in this case, the main thread.
//
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // check for HTTP status code for proxy authentication failures
    // anything in the 200 to 299 range is considered successful,
    // also make sure the MIMEType is correct:
    //
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2) && [[response MIMEType] isEqual:@"application/rss+xml"]) {
        self.JMCNewsData = [NSMutableData data];
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        [self handleError:error];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [JMCNewsData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    if ([error code] == kCFURLErrorNotConnectedToInternet) {
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo =
        [NSDictionary dictionaryWithObject:
         NSLocalizedString(@"No Connection Error",
                           @"Error message displayed when not connected to the Internet.")
                                    forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
                                                         code:kCFURLErrorNotConnectedToInternet
                                                     userInfo:userInfo];
        [self handleError:noConnectionError];
    } else {
        // otherwise handle the error generically
        [self handleError:error];
    }
    self.JMCNewsFeedConnection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    self.JMCNewsFeedConnection = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    // Spawn an NSOperation to parse the JMCNews data so that the UI is not blocked while the
    // application parses the XML data.
    //
    // IMPORTANT! - Don't access or affect UIKit objects on secondary threads.
    //
    JMCParseOperation *parseOperation = [[JMCParseOperation alloc] initWithData:self.JMCNewsData];
    [self.parseQueue addOperation:parseOperation];
    [parseOperation release];   // once added to the NSOperationQueue it's retained, we don't need it anymore
    
    // JMCNewsData will be retained by the NSOperation until it has finished executing,
    // so we no longer need a reference to it in the main thread.
    self.JMCNewsData = nil;
}

// Handle errors in the download by showing an alert to the user. This is a very
// simple way of handling the error, partly because this application does not have any offline
// functionality for the user. Most real applications should handle the error in a less obtrusive
// way and provide offline functionality to the user.
//
- (void)handleError:(NSError *)error {
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView =
    [[UIAlertView alloc] initWithTitle:
     NSLocalizedString(@"Error Title",
                       @"Title for alert displayed when download or parse error occurs.")
                               message:errorMessage
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

// Our NSNotification callback from the running NSOperation to add the JMCNews
//
- (void)addJMCNews:(NSNotification *)notif {
    assert([NSThread isMainThread]);
    
    [self addJMCNewsToList:[[notif userInfo] valueForKey:kJMCNewsResultsKey]];
}

// Our NSNotification callback from the running NSOperation to add the JMCNews
//
- (void)addCatgories:(NSNotification *)notif {
    assert([NSThread isMainThread]);
    
    [self addCategoriesToList:[[notif userInfo] valueForKey:kCategoriesResultsKey]];
}

// Our NSNotification callback from the running NSOperation when a parsing error has occurred
//
- (void)JMCNewsError:(NSNotification *)notif {
    assert([NSThread isMainThread]);
    
    [self handleError:[[notif userInfo] valueForKey:kJMCNewsMsgErrorKey]];
}

// Our NSNotification callback from the running NSOperation when a parsing error has occurred
//
- (void)categoriesError:(NSNotification *)notif {
    assert([NSThread isMainThread]);
    
    [self handleError:[[notif userInfo] valueForKey:kCategoriesMsgErrorKey]];
}

// The NSOperation "ParseOperation" calls addJMCNews: via NSNotification, on the main thread
// which in turn calls this method, with batches of parsed objects.
// The batch size is set via the kSizeOfJMCNewsBatch constant.
//
- (void)addJMCNewsToList:(NSArray *)news {
    
    // insert the JMCNews into our rootViewController's data source (for KVO purposes)
    [self.newsTabView insertJMCNews:news];
}

- (void)addCategoriesToList:(NSArray *)categories {
    
    // insert the JMCNews into our rootViewController's data source (for KVO purposes)
    [self.menuTabView insertCategories:categories];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
