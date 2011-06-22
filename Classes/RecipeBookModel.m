//
//  RecipeBookModel.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookModel.h"
#import "TouchXML.h"

@implementation RecipeBookModel

@synthesize recipes = _recipes, feedURL = _feedURL;

- (id)initWithCategory:(NSString *)category {
	page = 1;
	
  NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"RecipeCategories" ofType:@"plist"]]; 
	
	if ([dictionary objectForKey:category]){
		self.feedURL = [@"http://www.touchmusic.org.uk/recipebook/" stringByAppendingString:[dictionary objectForKey:category]];
	}
	else {
		self.feedURL = [[@"http://www.touchmusic.org.uk/recipebook/" stringByAppendingString:[category lowercaseString]] stringByAppendingString:@".xml"];
	}
  
  [dictionary release]; dictionary = nil;
	
	[super init];
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipes);
	TT_RELEASE_SAFELY(_feedURL);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if( !self.isLoading ) {
		if (more)
			page++;
		
		NSString* url= self.feedURL;
		
		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 600;
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send]; 
		
		
		NSLog(@"recipe book request sent");
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* response = request.response;
	
	TT_RELEASE_SAFELY(_recipes);
	_recipes = [[NSMutableDictionary alloc] init];
	
	
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithData:response.data options:0 error:nil] autorelease];
	
	// Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
	int outerCounter = 0;
	NSString* emptyString = @"";
	
	// Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
		
        // Create a counter variable as type "int"
        int counter;
		
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
			if ([[resultElement childAtIndex:counter] stringValue] == nil) {
				[blogItem setObject:emptyString 
							 forKey:[[resultElement childAtIndex:counter] name]];
			}
			else {
				// Add each field to the blogItem Dictionary with the node name as key and node value as the value
				[blogItem setObject:[[resultElement childAtIndex:counter] stringValue] 
							 forKey:[[resultElement childAtIndex:counter] name]];			
			}
		}
		
		if (!([[blogItem objectForKey:@"title"] isEqualToString:@"left"]) && !([[blogItem objectForKey:@"title"] isEqualToString:@"right"])) {
			// Add the blogItem to the global blogEntries Array so that the view can access it.
			NSNumber* key = [NSNumber numberWithInt:outerCounter];
			[_recipes setObject:[blogItem copy] forKey:key];
			outerCounter++;
		}
		
		[blogItem release];
	}	
	
	[super requestDidFinishLoad:request];
}

@end