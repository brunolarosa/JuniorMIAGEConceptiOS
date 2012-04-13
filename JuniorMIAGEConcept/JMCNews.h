//
//  JMCNews.h
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCNews : NSObject

@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSDate *pubDate;
@property (nonatomic, assign) NSString *author;
@property (nonatomic, assign) NSString *category;
@property (nonatomic, assign) NSString *description;

- (id)initWithTitle:(NSString *)newTitle 
            pubDate:(NSString *)newPubDate 
             author:(NSString *)newAuthor 
           category:(NSString *)newCategory 
        description:(NSString *)newDescription;

@end
