//
//  JMCMenuHeaderSectionView.m
//  JuniorMIAGEConcept
//
//  Created by Bruno LAROSA on 19/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCMenuHeaderSectionView.h"

#define TITLE_COLOR [UIColor colorWithRed:(196.0/255.0) green:(204.0/255.0) blue:(218.0/255.0) alpha:1.0]

@implementation JMCMenuHeaderSectionView

@synthesize sectionTitle = _sectionTitle;

- (UILabel *) sectionTitle
{
    if (!_sectionTitle)
        _sectionTitle = [[[UILabel alloc] initWithFrame:CGRectMake(10, 0, 310, 25)] retain];
    return _sectionTitle;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        UIImageView * background = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sectionHeader.png"]] autorelease];
        [self addSubview:background];
        
        
        self.sectionTitle.font = [UIFont boldSystemFontOfSize:13];
        self.sectionTitle.backgroundColor = [UIColor clearColor];
        
        self.sectionTitle.textColor = TITLE_COLOR;
        
        self.sectionTitle.shadowColor = [UIColor blackColor];
        self.sectionTitle.shadowOffset = CGSizeMake(0, 1);
        
        [self addSubview:self.sectionTitle];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_sectionTitle release];
    [super dealloc];
}
@end
