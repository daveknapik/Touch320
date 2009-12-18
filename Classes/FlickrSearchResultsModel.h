//
//  FlickrSearchResultsModel.h
//
//  Created by Keith Lazuka on 7/23/09.
//  
//

#import "Three20/Three20.h"

@class URLModelResponse;

@interface FlickrSearchResultsModel : TTURLRequestModel
{
    URLModelResponse *responseProcessor;
    NSArray *results;
	NSUInteger totalResultsAvailableOnServer;
	NSString *searchTerms;
    NSUInteger page;
}

@property (nonatomic, readonly) NSArray *results;                           // A list of domain objects constructed by the model after parsing the web service's HTTP response. In this case, it is a list of SearchResult objects.
@property (nonatomic, readonly) NSUInteger totalResultsAvailableOnServer;   // The total number of results available on the server (but not necessarily downloaded) for the current model configuration's search query.
@property (nonatomic, retain) NSString *searchTerms;                        // The keywords that will be submitted to the web service in order to do the actual image search (e.g. "green apple")


@end
