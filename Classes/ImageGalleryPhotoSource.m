//
//  ImageGalleryPhotoSource.m
//

#import "ImageGalleryPhotoSource.h"
#import "ImageGalleryPhoto.h"
#import "Touch320AppDelegate.h"
#import "GTMNSDictionary+URLArguments.h"

@implementation ImageGalleryPhotoSource
@synthesize title = _title;

- (id)init {
	_title = @"Images";
	
	page = 1;
    responseProcessor = [[FlickrJSONResponse alloc] init];
	
	return self;
}

- (NSArray *)flickrPhotos
{
    return [[[responseProcessor objects] copy] autorelease];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTPhotoSource

- (NSInteger)numberOfPhotos {
	return [responseProcessor totalObjectsAvailableOnServer];
}

- (NSInteger)maxPhotoIndex {
	return [self flickrPhotos].count - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index {
	if (index < [self flickrPhotos].count) {
		id<TTPhoto> photo = [[self flickrPhotos] objectAtIndex:index];
		photo.index = index;
		photo.photoSource = self;
		return photo;
	} else {
		return nil;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModel

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (more) {
		page++;
	}
	
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	/*NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.photos.search", @"method",
                                @"Philip Jeck", @"text",
                                @"url_o,url_m,url_t", @"extras",
                                @"dcb74491ec5cbe64deb98b18df1125a9", @"api_key",
                                @"json", @"format",
                                [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
                                @"40", @"per_page",
                                @"1", @"nojsoncallback",
                                nil];*/
	
	NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.photosets.getPhotos", @"method",
                                @"72157627186163266", @"photoset_id",
                                @"url_l,url_z,url_m,url_t", @"extras",
                                @"dcb74491ec5cbe64deb98b18df1125a9", @"api_key",
                                @"json", @"format",
                                [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
                                appDelegate.numberOfThumbnails, @"per_page",
                                @"1", @"nojsoncallback",
                                nil];
	
    NSString *url = [@"http://api.flickr.com/services/rest/" stringByAppendingFormat:@"?%@", [parameters gtm_httpArgumentsString]];
	
	TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
	request.cachePolicy = cachePolicy;
	request.cacheExpirationAge = 600;
	//request.cachePolicy = TTURLRequestCachePolicyNone;
	// sets the response
	request.response = responseProcessor;
    request.httpMethod = @"GET";
    NSLog(@"%@",url);
    // Dispatch the request.
    [request send];
}

@end
