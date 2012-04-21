//
//  JMCParser.m
//  JuniorMIAGEConcept
//
//  Created by Hugo Vicard on 04/04/12.
//  Copyright (c) 2012 Hugo Vicard. All rights reserved.
//

#import "JMCParser.h"

@interface JMCParser (Private)

-(void)dispatchLoadingOperation;
-(JMCNews *)getItemFromXmlElement:(GDataXMLElement*)xmlItem;

@end


@implementation JMCParser

@synthesize delegate, loaded;

-(id)init 
{
	if ([super init]!=nil) {
		self.loaded = NO;
	}
	return self;
}

-(void)load
{
	[self dispatchLoadingOperation];
}

-(void)dealloc
{
	self.delegate = nil;
	[super dealloc];
}

// Pour avoir un meilleur lancement de l'application
// on cree un thread pour le chargement des news
-(void)dispatchLoadingOperation
{
	NSOperationQueue *queue = [NSOperationQueue new];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(fetchRSS)
																			  object:nil];
	
	[queue addOperation:operation];
	[operation release];
	[queue autorelease];
}

-(void)fetchRSS
{	
	NSLog(@"fetch rss");
	NSData* xmlData = [[NSMutableData alloc] initWithContentsOfURL:[NSURL URLWithString: kRSSUrl] ];
    NSError *error;
	
    GDataXMLDocument* doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&error];
	
	if (doc != nil) {
		self.loaded = YES;
		
		GDataXMLNode* title = [[[doc rootElement] nodesForXPath:@"channel/title" error:&error] objectAtIndex:0];
		[self.delegate updatedFeedTitle: [title stringValue] ];
		
		NSArray* items = [[doc rootElement] nodesForXPath:@"channel/item" error:&error];
		NSMutableArray* JMCNewsList = [NSMutableArray arrayWithCapacity:[items count] ];
		
		for (GDataXMLElement* xmlItem in items) {
			[JMCNewsList addObject: [self getItemFromXmlElement:xmlItem] ];
		}
        
		[self.delegate performSelectorOnMainThread:@selector(updatedFeedWithRSS:) withObject:JMCNewsList waitUntilDone:YES];
	} else {
		[self.delegate performSelectorOnMainThread:@selector(failedFeedUpdateWithError:) withObject:error waitUntilDone:YES];
	}
    
    [doc autorelease];
    [xmlData release];
}

-(JMCNews *)getItemFromXmlElement:(GDataXMLElement*)xmlItem
{
    /*
    JMCNews *news = [[[JMCNews alloc]initWithTitle:[[[xmlItem elementsForName:@"title"] objectAtIndex:0] stringValue] 
                                         pubDate:[[[xmlItem elementsForName:@"pubDate"] objectAtIndex:0] stringValue]
                                          author:[[[xmlItem elementsForName:@"dc:creator"] objectAtIndex:0] stringValue]
                                        category:[[[xmlItem elementsForName:@"category"] objectAtIndex:0] stringValue]
                                      description:[[[xmlItem elementsForName:@"description"] objectAtIndex:0] stringValue]
                     ] autorelease];
    NSLog(@"%@",news.title);*/
	return nil;
}

/*
+ (void)saveXMLFeed:(Party *)party {
    
    GDataXMLElement * partyElement = [GDataXMLNode elementWithName:@"Party"];

    
    GDataXMLDocument *document = [[[GDataXMLDocument alloc] 
                                   initWithRootElement:partyElement] autorelease];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:TRUE];
    NSLog(@"Saving xml data to %@...", filePath);
    [xmlData writeToFile:filePath atomically:YES];
    
}
*/

@end