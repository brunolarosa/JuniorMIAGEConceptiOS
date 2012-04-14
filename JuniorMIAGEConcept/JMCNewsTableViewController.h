//
//  JMCNewsTableViewController.h
//  JuniorMIAGEConcept
//
//  Created by Bruno Larosa on 04/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCParser.h"

@interface JMCNewsTableViewController : UITableViewController<JMCParserDelegate>
{
    JMCParser* rss;
    NSMutableArray *jmcNewsList;
}

@property (nonatomic, retain) NSMutableArray *jmcNewsList;
@property (nonatomic, retain) JMCParser* rss;


@end
