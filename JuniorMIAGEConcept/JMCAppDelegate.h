//
//  JMCAppDelegate.h
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCParser.h"

@interface JMCAppDelegate : UIResponder <UIApplicationDelegate, NSXMLParserDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UITableViewController *leftViewController;
@property (retain, nonatomic) UIViewController* centerViewController;

- (void)loadRssFeed;

@end
