//
//  JMCNewsCell.h
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 19/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMCNewsCell : UITableViewCell

@property (assign, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) UILabel *resumeLabel;
@property (assign, nonatomic) UILabel *footerLabel;
@property (assign, nonatomic) UILabel *commentsLabel;
@property (assign, nonatomic) UIImageView *newsImage;

@end
