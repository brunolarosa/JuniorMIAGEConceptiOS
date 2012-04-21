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

- (id)initWithTitle:(NSString *)newTitle 
            pubDate:(NSString *)newPubDate 
             author:(NSString *)newAuthor 
           category:(NSString *)newCategory 
        description:(NSString *)newDescription{
    
    if ((self = [super init])) {
        self.title = newTitle;
        self.pubDate = newPubDate;
        self.author = newAuthor;
        self.category = newCategory;
        self.description = newDescription;
    }    
    return self;
    
}


@end
