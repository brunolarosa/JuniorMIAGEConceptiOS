//
//  JMCNews.m
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import "JMCNews.h"

@implementation JMCNews


@synthesize title = _title;
@synthesize pubDate = _pubDate;
@synthesize author = _author;
@synthesize category = _category;
@synthesize description = _description;

- (void) dealloc {
    [_title release];
    [_pubDate release];
    [_author release];
    [_category release];
    [_description release];
    [super dealloc];
}



@end
