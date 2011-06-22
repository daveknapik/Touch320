//
//  NewsModel.m
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsModel.h"
#import "TouchXML.h"

@implementation NewsModel

@synthesize newsItems = _newsItems;

- (id)init {
	page = 1;
	[super init];
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_newsItems);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if( !self.isLoading ) {
		if (more)
			page++;
		
		NSString* url=@"http://www.touchmusic.org.uk/iphone.xml";
		
		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		request.cachePolicy = cachePolicy;
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		NSLog(@"request sent");
		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	request.cacheExpirationAge = 600;
	
	TTURLDataResponse* response = request.response;
	
	TT_RELEASE_SAFELY(_newsItems);
	_newsItems = [[NSMutableDictionary alloc] init];
	
	CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithData:response.data options:0 error:nil] autorelease];
	
	// Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
	int outerCounter = 0;
	
	// Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
		
        // Create a counter variable as type "int"
        int counter;
		
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
			
            // Add each field to the blogItem Dictionary with the node name as key and node value as the value
            [blogItem setObject:[[resultElement childAtIndex:counter] stringValue] 
						 forKey:[[resultElement childAtIndex:counter] name]];
		}
		
		
		//NSString* key = [NSString stringWithFormat:@"%d",outerCounter];
		NSNumber* key = [NSNumber numberWithInt:outerCounter];
		
		// Add the blogItem to the global blogEntries Array so that the view can access it.
		[_newsItems setObject:blogItem forKey:key];
		
		outerCounter++;
		[blogItem release];
	}	
	
	[super requestDidFinishLoad:request];
}

/*-(void)didFailLoadWithError:(NSError *)error {
	NSLog(@"error: %@",error);
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	
	// Set the Error View
	TTErrorView* errorView = [[TTErrorView alloc] initWithTitle:@"LOL" subtitle:@"LMFAO." image:nil];
	errorView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
	
	self.errorView = errorView;
}*/

@end
