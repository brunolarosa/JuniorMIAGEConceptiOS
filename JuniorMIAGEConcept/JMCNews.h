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
NSMutableArray *category;
NSString *description;

}
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *pubDate;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSMutableArray *category;
@property (nonatomic, retain) NSString *description;




@end
