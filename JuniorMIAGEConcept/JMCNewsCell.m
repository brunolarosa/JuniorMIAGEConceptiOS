//
//  JMCNewsCell.m
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 19/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCNewsCell.h"

#define CELL_WIDTH 80

#define FOOTER_NEWS_COLOR [UIColor colorWithRed:(203.0/255.0) green:(214.0/255.0) blue:(240.0/255.0) alpha:1.0]
#define FOOTER_WIDTH 20

#define TEXT_NEWS_COLOR [UIColor colorWithRed:(92.0/255.0) green:(111.0/255.0) blue:(152.0/255.0) alpha:1.0]

#define MARGIN_TEXT 40

@interface JMCNewsCell()



@end

@implementation JMCNewsCell

@synthesize titleLabel = _titleLabel;
@synthesize resumeLabel = _resumeLabel;
@synthesize footerLabel = _footerLabel;
@synthesize commentsLabel = _commentsLabel;
@synthesize newsImage = _newsImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIView *background = [[[UIView alloc] initWithFrame:CGRectZero] autorelease];
        background.backgroundColor = [UIColor whiteColor];
        self.backgroundView = background;
        
     /* TITLE LABEL */           
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(MARGIN_TEXT, 5, 300-MARGIN_TEXT, 20)] autorelease];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        self.titleLabel.textColor = TEXT_NEWS_COLOR;
        [self.contentView addSubview: self.titleLabel];
    
    /* Resume Label */
        self.resumeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(MARGIN_TEXT, 27, 300-MARGIN_TEXT, 30)] autorelease];
        self.resumeLabel.backgroundColor = [UIColor clearColor];
        self.resumeLabel.numberOfLines = 2;
        self.resumeLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview: self.resumeLabel];

        
        
        
    /* Footer Cell */
        UIView *footerNews = [[[UIView alloc] initWithFrame:CGRectMake(0, CELL_WIDTH-FOOTER_WIDTH, 300, FOOTER_WIDTH)] autorelease];
        footerNews.backgroundColor = FOOTER_NEWS_COLOR;
        
        /* Footer Lable */
        self.footerLabel = [[[UILabel alloc] initWithFrame:CGRectMake(5, 0, 200, FOOTER_WIDTH)]autorelease];
        self.footerLabel.backgroundColor = [UIColor clearColor];
        self.footerLabel.font = [UIFont systemFontOfSize:10];
        self.footerLabel.textColor = TEXT_NEWS_COLOR;
        [footerNews addSubview:self.footerLabel];
        
        /* Comments View */
        UIView *comments = [[[UIView alloc] initWithFrame:CGRectMake(250, 0, 30, FOOTER_WIDTH)] autorelease];
        UIImageView *iconComments= [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bubleComment.png"]]autorelease];
        [comments addSubview:iconComments];
        self.commentsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(9, 0, 20, FOOTER_WIDTH-4)] autorelease];
        self.commentsLabel.font = [UIFont systemFontOfSize:10];
        self.commentsLabel.textColor = TEXT_NEWS_COLOR;
        self.commentsLabel.backgroundColor = [UIColor clearColor];
        [comments addSubview:self.commentsLabel];

        
        [footerNews addSubview:comments];
        
        [self.contentView addSubview: footerNews];

        
        
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
