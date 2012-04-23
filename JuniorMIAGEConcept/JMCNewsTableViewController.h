//
//  JMCNewsTableViewController.h
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCParser.h"
#import "JMCNews.h"
#import "JMCNewsCell.h"
#import "JMCNewsViewController.h"
#import "JMCAppDelegate.h"
#import "IIViewDeckController.h"


@interface JMCNewsTableViewController : UITableViewController<UIActionSheetDelegate>
{
    NSMutableArray *jmcNewsList;
    NSString *selectedCategory;
}

@property (nonatomic, retain) NSMutableArray *jmcNewsList;
@property (nonatomic, retain) NSString *selectedCategory;
- (void)insertJMCNews:(NSArray *)aJMCNews;


@end
