//
//  RadioModel.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioModel.h"
#import "TouchXML.h"

@implementation RadioModel

@synthesize radioItems = _radioItems;

- (id)init {
	page = 1;
	[super init];
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_radioItems);
	[super dealloc];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if( !self.isLoading ) {
		if (more)
			page++;
		
		//NSString* url=@"http://www.touchmusic.org.uk/TouchPod/podcast.xml";
		NSString* url=@"http://www.touchmusic.org.uk/TouchiPhoneRadio/podcast.xml";
		
		TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 600;
		
		id<TTURLResponse> response = [[TTURLDataResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		NSLog(@"radio request sent");
		[request send];
	}
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLDataResponse* response = request.response;
	
	TT_RELEASE_SAFELY(_radioItems);
	_radioItems = [[NSMutableDictionary alloc] init];
	
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
			
			if ([[[resultElement childAtIndex:counter] name] isEqualToString:@"enclosure"]) {
			}
			else {
				// Add each field to the blogItem Dictionary with the node name as key and node value as the value
				[blogItem setObject:[[resultElement childAtIndex:counter] stringValue] 
							 forKey:[[resultElement childAtIndex:counter] name]];
			}
		}
				
		//NSString* key = [NSString stringWithFormat:@"%d",outerCounter];
		NSNumber* key = [NSNumber numberWithInt:outerCounter];
		
		// Add the blogItem to the global blogEntries Array so that the view can access it.
		[_radioItems setObject:blogItem forKey:key];
		
		//NSLog(@"my dictionary = %@", blogItem);
		
		outerCounter++;
		[blogItem release];
	}	
	
	[super requestDidFinishLoad:request];
}

@end
