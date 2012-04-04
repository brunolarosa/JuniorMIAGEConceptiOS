//
//  JMCNews.m
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import "JMCNews.h"

@implementation JMCNews


@synthesize title;
@synthesize pubDate;
@synthesize author;
@synthesize category;
@synthesize description;

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

- (void) dealloc {
    self.title = nil;    
    [super dealloc];
}


@end
