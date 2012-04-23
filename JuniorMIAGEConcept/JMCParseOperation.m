//
//  JMCParseOperation.m
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 19/04/12.
//  Copyright (c) 2012 Université Nice Sophia Antipolis. All rights reserved.
//

#import "JMCParseOperation.h"

#import "JMCNews.h"

// NSNotification name for sending JMCNews data back to the app delegate
NSString *kAddJMCNewsNotif = @"AddJMCNewsNotif";

// NSNotification userInfo key for obtaining the JMCNews data
NSString *kJMCNewsResultsKey = @"JMCNewsResultsKey";

// NSNotification name for reporting errors
NSString *kJMCNewsErrorNotif = @"JMCNewsErrorNotif";

// NSNotification userInfo key for obtaining the error message
NSString *kJMCNewsMsgErrorKey = @"JMCNewsMsgErrorKey";


@interface JMCParseOperation () <NSXMLParserDelegate>

@property (nonatomic, retain) JMCNews *currentJMCNewsObject;
@property (nonatomic, retain) NSMutableArray *currentParseBatch;
@property (nonatomic, retain) NSMutableArray *currentCategories;
@property (nonatomic, retain) NSMutableString *currentParsedCharacterData;
@end

@interface JMCParseOperation ()

@property (nonatomic, assign) NSDateFormatter *dateFormatterFromDate;
@property (nonatomic, assign) NSDateFormatter *dateFromatterFromString;

@end

@implementation JMCParseOperation

@synthesize JMCNewsData, currentJMCNewsObject, currentParsedCharacterData, currentParseBatch, currentCategories;

@synthesize dateFormatterFromDate = _dateFormatterFromDate;
@synthesize dateFromatterFromString = _dateFromatterFromString;

- (id)initWithData:(NSData *)xmlData
{
    if (self = [super init]) {    
        JMCNewsData = [xmlData copy];
    }
    return self;
}

- (NSDateFormatter *) dateFormatterFromDate
{
    if (!_dateFormatterFromDate)
    {
        _dateFormatterFromDate = [[[NSDateFormatter alloc] init] autorelease];
        [_dateFormatterFromDate setDateFormat:@"EEE dd MMM yyyy 'à' HH:mm"];
        [_dateFormatterFromDate setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"]autorelease]];

    }

    return _dateFormatterFromDate;
}

- (NSDateFormatter *) dateFromatterFromString
{
    if (!_dateFromatterFromString)
    {
        _dateFromatterFromString = [[[NSDateFormatter alloc] init] autorelease];
        [_dateFromatterFromString setDateFormat:@"EEE, dd MMM yy HH:mm:ss Z"];
    }
    return _dateFromatterFromString;
}


- (void)addJMCNewsToList:(NSArray *)JMCNews {
    assert([NSThread isMainThread]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kAddJMCNewsNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:JMCNews
                                                                                           forKey:kJMCNewsResultsKey]]; 
}

// the main function for this NSOperation, to start the parsing
- (void)main {
    self.currentParseBatch = [NSMutableArray array];
    self.currentCategories = [NSMutableArray array];
    self.currentParsedCharacterData = [NSMutableString string];
    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is
    // not desirable because it gives less control over the network, particularly in responding to
    // connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.JMCNewsData];
    [parser setDelegate:self];
    [parser parse];
    
    // depending on the total number of JMCNewss parsed, the last batch might not have been a
    // "full" batch, and thus not been part of the regular batch transfer. So, we check the count of
    // the array and, if necessary, send it to the main thread.
    //
    if ([self.currentParseBatch count] > 0)
    {
        
        NSLog(@"main - JMCParseOperation - addJMCNewsToList");
        NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                self.currentParseBatch, @"news",
                                self.currentCategories, @"categories",
                                nil];
        [self performSelectorOnMainThread:@selector(addJMCNewsToList:)
                               withObject:dic
                            waitUntilDone:YES];
        [dic release];
    }
    
    self.currentParseBatch = nil;
    self.currentCategories = nil;
    self.currentJMCNewsObject = nil;
    self.currentParsedCharacterData = nil;
    
    [parser release];
}

- (void)dealloc {
    [JMCNewsData release];
    [currentJMCNewsObject release];
    [currentParsedCharacterData release];
    [currentParseBatch release];
    [currentCategories release];
    
    [super dealloc];
}


#pragma mark -
#pragma mark Parser constants

// Limit the number of parsed JMCNewss to 50
// (a given day may have more than 50 JMCNewss around the world, so we only take the first 20)
//
static const const NSUInteger kMaximumNumberOfJMCNewsToParse = 20;

// When an JMCNews object has been fully constructed, it must be passed to the main thread and
// the table view in RootViewController must be reloaded to display it. It is not efficient to do
// this for every JMCNews object - the overhead in communicating between the threads and reloading
// the table exceed the benefit to the user. Instead, we pass the objects in batches, sized by the
// constant below. In your application, the optimal batch size will vary 
// depending on the amount of data in the object and other factors, as appropriate.
//
static NSUInteger const kSizeOfJMCNewsBatch = 100;

static NSString * const kItemElementName = @"item";
static NSString * const kPubDateName = @"pubDate";
static NSString * const kTitleElementName = @"title";
static NSString * const kAuthorElementName = @"dc:creator";
static NSString * const kCategoryElementName = @"category";
static NSString * const kDescriptionElementName = @"description";
static NSString * const kContentElementName = @"content:encoded";

#pragma mark -
#pragma mark NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    
//    NSLog(@"Test Parser didStartElt + eltName : %@", elementName );
    
    // If the number of parsed JMCNewss is greater than
    // kMaximumNumberOfJMCNewssToParse, abort the parse.
    //
    if (parsedJMCNewsCounter >= kMaximumNumberOfJMCNewsToParse)
    {
        // Use the flag didAbortParsing to distinguish between this deliberate stop
        // and other parser errors.
        //
        didAbortParsing = YES;
        [parser abortParsing];
    }
    if ([elementName isEqualToString:kItemElementName])
    {
        JMCNews *aJMCNews = [[JMCNews alloc]init];
        self.currentJMCNewsObject = aJMCNews;
        self.currentJMCNewsObject.category = [[[NSMutableArray alloc] init] autorelease];
        [aJMCNews release];

    }
    else if ([elementName isEqualToString:kTitleElementName] ||
             [elementName isEqualToString:kPubDateName] ||
             [elementName isEqualToString:kAuthorElementName] ||
             [elementName isEqualToString:kCategoryElementName] ||
             [elementName isEqualToString:kDescriptionElementName] ||
             [elementName isEqualToString:kContentElementName])
    {
        // For the 'title', 'updated', or 'georss:point' element begin accumulating parsed character data.
        // The contents are collected in parser:foundCharacters:.
        accumulatingParsedCharacterData = YES;
        // The mutable string needs to be reset to empty.
        [currentParsedCharacterData setString:@""];
    }
}

- (NSString *) formatDateFromString:(NSString *) stringDate
{           
    NSDate *date = [self.dateFromatterFromString dateFromString:stringDate];
    
    return [self.dateFormatterFromDate stringFromDate:date];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {     

    if ([elementName isEqualToString:kItemElementName]) {
        NSLog(@"Ajout de l'article : %@", currentJMCNewsObject.title);
        [self.currentParseBatch addObject:self.currentJMCNewsObject];
        parsedJMCNewsCounter++;
        if ([self.currentParseBatch count] >= kMaximumNumberOfJMCNewsToParse) {

            [self performSelectorOnMainThread:@selector(addJMCNewsToList:)
                                   withObject:self.currentParseBatch
                                waitUntilDone:NO];

            self.currentParseBatch = [NSMutableArray array];
        }
    } else if ([elementName isEqualToString:kTitleElementName]) {
        if (self.currentJMCNewsObject != nil) {
            self.currentJMCNewsObject.title = [[self.currentParsedCharacterData copy] autorelease];
        }
    } else if ([elementName isEqualToString:kPubDateName]) {
        if (self.currentJMCNewsObject != nil)
        {
           self.currentJMCNewsObject.pubDate = [self formatDateFromString:self.currentParsedCharacterData];
            
        }
    } else if ([elementName isEqualToString:kAuthorElementName]) {
        if (self.currentJMCNewsObject != nil) {
            self.currentJMCNewsObject.author = [[self.currentParsedCharacterData copy] autorelease];
        }
    }
    else if ([elementName isEqualToString:kCategoryElementName]) {
        if (self.currentJMCNewsObject != nil) {
            [self.currentJMCNewsObject.category addObject:[[self.currentParsedCharacterData copy] autorelease]];
            if (![currentCategories containsObject:self.currentParsedCharacterData ]) {
                [self.currentCategories addObject:[[self.currentParsedCharacterData copy] autorelease]];                
            }
        }
    }
    else if ([elementName isEqualToString:kDescriptionElementName]) {
        if (self.currentJMCNewsObject != nil) {
            self.currentJMCNewsObject.description = [[self.currentParsedCharacterData copy] autorelease];
        }
    }
    else if ([elementName isEqualToString:kContentElementName]) {
        if (self.currentJMCNewsObject != nil) {
            self.currentJMCNewsObject.content = [[self.currentParsedCharacterData copy] autorelease];
        }
    }
    
    // Stop accumulating parsed character data. We won't start again until specific elements begin.
    accumulatingParsedCharacterData = NO;
}

// This method is called by the parser when it find parsed character data ("PCDATA") in an element.
// The parser is not guaranteed to deliver all of the parsed character data for an element in a single
// invocation, so it is necessary to accumulate character data until the end of the element is reached.
//
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (accumulatingParsedCharacterData) {
        // If the current element is one whose content we care about, append 'string'
        // to the property that holds the content of the current element.
        
        [self.currentParsedCharacterData appendString:string];
    }
}

// an error occurred while parsing the JMCNews data,
// post the error as an NSNotification to our app delegate.
// 
- (void)handleJMCNewsError:(NSError *)parseError {
    [[NSNotificationCenter defaultCenter] postNotificationName:kJMCNewsErrorNotif
                                                        object:self
                                                      userInfo:[NSDictionary dictionaryWithObject:parseError
                                                                                           forKey:kJMCNewsMsgErrorKey]];
}

// an error occurred while parsing the JMCNews data,
// pass the error to the main thread for handling.
// (note: don't report an error if we aborted the parse due to a max limit of JMCNewss)
//
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if ([parseError code] != NSXMLParserDelegateAbortedParseError && !didAbortParsing)
    {
        [self performSelectorOnMainThread:@selector(handleJMCNewssError:)
                               withObject:parseError
                            waitUntilDone:NO];
    }
}
@end
