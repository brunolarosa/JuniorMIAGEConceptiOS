//
//  JMCParser.h
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
#import "JMCNews.h"
#define kRSSUrl @"http://jmc-miage.unice.fr/projects/jmc/complet/feed/"

@protocol JMCParserDelegate
@required
-(void)updatedFeedWithRSS:(NSArray*)items;
-(void)failedFeedUpdateWithError:(NSError*)error;
-(void)updatedFeedTitle:(NSString*)title;
@end

@interface JMCParser : NSObject {
	UIViewController<JMCParserDelegate> * delegate;
	BOOL loaded;
}

@property (retain, nonatomic) UIViewController<JMCParserDelegate> * delegate;
@property (nonatomic, assign) BOOL loaded;

-(void)load;
@end
