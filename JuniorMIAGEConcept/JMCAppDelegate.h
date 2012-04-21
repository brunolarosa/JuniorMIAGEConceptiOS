//
//  JMCAppDelegate.h
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCParser.h"

@interface JMCAppDelegate : UIResponder <UIApplicationDelegate, NSXMLParserDelegate>{

@private
// for downloading the xml data
NSURLConnection *JMCNewsFeedConnection;
NSMutableData *JMCNewsData;

NSOperationQueue *parseQueue;
}

@property (strong, nonatomic) UIWindow *window;

@property (retain, nonatomic) UITableViewController *leftViewController;
@property (retain, nonatomic) UIViewController* centerViewController;

@end
