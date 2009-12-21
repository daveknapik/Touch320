//
//  FlickrJSONResponse.m
//
//  based on http://github.com/klazuka/TTRemoteExamples

#import "FlickrJSONResponse.h"
#import "JSON/JSON.h"
#import "ImageGalleryPhoto.h"

@implementation FlickrJSONResponse
@synthesize objects, totalObjectsAvailableOnServer;

- (id)init {
	objects = [[NSMutableArray alloc] init];
	return self;
}

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Parse the JSON data that we retrieved from the server.
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // Drill down into the JSON object to get the parts
    // that we're actually interested in.
    NSDictionary *root = [json objectForKey:@"photos"];
    totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];
	
    // Create the ImageGalleryPhotos
    NSArray *results = [root objectForKey:@"photo"];
    for (NSDictionary *rawResult in results) {        
		
		NSString* bigURL = [rawResult objectForKey:@"url_m"];
		NSString* smallURL = [rawResult objectForKey:@"url_t"];
		NSString* title = [rawResult objectForKey:@"title"];
		CGSize bigSize = CGSizeMake([[rawResult objectForKey:@"width_m"] floatValue],
									[[rawResult objectForKey:@"height_m"] floatValue]);
		
		ImageGalleryPhoto* photo = [[[ImageGalleryPhoto alloc] initWithURL:bigURL smallURL:smallURL size:bigSize caption:title] autorelease];
		
        [self.objects addObject:photo];
    }
    
    return nil;
}


@end
