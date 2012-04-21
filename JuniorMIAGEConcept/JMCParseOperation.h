//
//  JMCParseOperation.h
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 19/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *kAddJMCNewsNotif;
extern NSString *kJMCNewsResultsKey;

extern NSString *kJMCNewsErrorNotif;
extern NSString *kJMCNewsMsgErrorKey;

@class JMCNews;

@interface JMCParseOperation : NSOperation {
    NSData *JMCNewsData;
@private
    NSDateFormatter *dateFormatter;

// these variables are used during parsing
JMCNews *currentJMCNewsObject;
NSMutableArray *currentParseBatch;
NSMutableString *currentParsedCharacterData;

BOOL accumulatingParsedCharacterData;
BOOL didAbortParsing;
NSUInteger parsedJMCNewsCounter;
}

@property (copy, readonly) NSData *JMCNewsData;

@end
