//
//  JMCMenuViewController.h
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 16/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IIViewDeckController.h"
#import "JMCNewsTableViewController.h"
#import "JMCMenuHeaderSectionView.h"

@interface JMCMenuViewController : UITableViewController
{
    NSMutableArray *categories;
}
@property (retain, nonatomic) NSMutableArray *categories;
- (void) insertCategories:(NSArray *) someCategories;
- (void) refreshPressed;
@end
