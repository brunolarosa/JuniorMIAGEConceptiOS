//
//  JMCNews.h
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCNews : NSObject

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSDate *pubDate;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *description;;

- (id)initWithTitle:(NSString *)newTitle 
            pubDate:(NSString *)newPubDate 
             author:(NSString *)newAuthor 
           category:(NSString *)newCategory 
        description:(NSString *)newDescription;

+ (NSArray *) getNewsFromCategory:(NSArray *) anArray
                         category:(NSString *)aCategory;

@end
