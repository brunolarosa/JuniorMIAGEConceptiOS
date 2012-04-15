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

- (id)initWithTitle:(NSString *)newTitle 
           pubDate:(NSDate *)newPubDate 
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

+ (NSArray *) getNewsFromCategory:(NSArray *)anArray
                         category:(NSString *)aCategory{
    
    NSEnumerator *e = [anArray objectEnumerator];
    NSMutableArray *returnValues = [[NSMutableArray alloc] init];
    JMCNews *object = nil;
    while (object = [e nextObject]) {
        if([object.category isEqualToString:aCategory]){
            [returnValues addObject:object];
        }            
    }
    return returnValues;    
}

- (void) dealloc {
    [_title release];
    [_pubDate release];
    [_author release];
    [_category release];
    [_description release];
    [super dealloc];
}


@end
