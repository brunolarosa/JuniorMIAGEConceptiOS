//
//  JMCNewsViewController.h
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 14/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMCNews.h"

@interface JMCNewsViewController : UIViewController

@property (retain, nonatomic) JMCNews *jmcNews;
@property (retain, nonatomic) IBOutlet UILabel *newsTitle;

@end
