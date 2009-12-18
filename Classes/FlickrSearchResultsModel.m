//
//  FlickrSearchResultsModel.m
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "FlickrSearchResultsModel.h"
#import "FlickrJSONResponse.h"
#import "GTMNSDictionary+URLArguments.h"

const static NSUInteger kFlickrBatchSize = 16;   // The number of results to pull down with each request to the server.

@implementation FlickrSearchResultsModel

@synthesize searchTerms;

- (id)init
{
	if ((self = [super init])) {
        responseProcessor = [[FlickrJSONResponse alloc] init];																	
        page = 1;
    }
    return self;
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more
{
    if (!searchTerms) {
        TTLOG(@"No search terms specified. Cannot load the model resource.");
        return;
    }
    
    if (more)
        page++;
    else
        [responseProcessor.objects removeAllObjects]; // Clear out data from previous request.
    
    NSString *batchSize = [NSString stringWithFormat:@"%lu", (unsigned long)kFlickrBatchSize];
    
    // Construct the request.
    NSString *host = @"http://api.flickr.com";
    NSString *path = @"/services/rest/";
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.photos.search", @"method",
                                searchTerms, @"text",
                                @"url_m,url_t", @"extras",
                                @"dcb74491ec5cbe64deb98b18df1125a9", @"api_key", // I am providing my own API key as a convenience because I'm trusting you not to use it for evil.
                                [responseProcessor format], @"format",
                                [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
                                batchSize, @"per_page",
                                @"1", @"nojsoncallback",
                                nil];
            
    NSString *url = [host stringByAppendingFormat:@"%@?%@", path, [parameters gtm_httpArgumentsString]];
    TTURLRequest *request = [TTURLRequest requestWithURL:url delegate:self];
    request.cachePolicy = cachePolicy;
    request.response = responseProcessor;
    request.httpMethod = @"GET";
    
    // Dispatch the request.
    [request send];
}

- (void)reset
{
    [super reset];
    [searchTerms release];
    searchTerms = nil;
    page = 1;
    [[responseProcessor objects] removeAllObjects];
}

- (void)setSearchTerms:(NSString *)theSearchTerms
{
    if (![theSearchTerms isEqualToString:searchTerms]) {
        [searchTerms release];
        searchTerms = [theSearchTerms retain];
        page = 1;
    }
}

- (NSArray *)results
{
    return [[[responseProcessor objects] copy] autorelease];
}

- (NSUInteger)totalResultsAvailableOnServer
{
    return [responseProcessor totalObjectsAvailableOnServer];
}

- (void)dealloc
{
    [searchTerms release];
    [responseProcessor release];
    [super dealloc];
}



@end
