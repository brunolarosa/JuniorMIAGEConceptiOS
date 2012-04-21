//
//  JMCNews.h
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMCNews : NSObject {
@private
NSString *title;
NSString *pubDate;
NSString *author;
NSString *category;
NSString *description;

}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *pubDate;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *description;

- (id)initWithTitle:(NSString *)newTitle 
            pubDate:(NSString *)newPubDate 
             author:(NSString *)newAuthor 
           category:(NSString *)newCategory 
        description:(NSString *)newDescription;



@end
