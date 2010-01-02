//
//  ImageGalleryPhotoSource.m
//

#import "ImageGalleryPhotoSource.h"
#import "ImageGalleryPhoto.h"


@implementation ImageGalleryPhotoSource
@synthesize title = _title;

- (id)init {
	_title = @"Listening Eye";
	
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
	NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"flickr.photos.search", @"method",
                                @"Philip Jeck", @"text",
                                @"url_o,url_m,url_t", @"extras",
                                @"dcb74491ec5cbe64deb98b18df1125a9", @"api_key",
                                @"json", @"format",
                                [NSString stringWithFormat:@"%lu", (unsigned long)page], @"page",
                                @"40", @"per_page",
                                @"1", @"nojsoncallback",
                                nil];
	
    NSString *url = [@"http://api.flickr.com/services/rest/" stringByAppendingFormat:@"?%@", [parameters gtm_httpArgumentsString]];
	NSLog(@"url: %@", url);
	TTURLRequest* request = [TTURLRequest requestWithURL:url delegate:self];
	request.cachePolicy = cachePolicy;
	// sets the response
	request.response = responseProcessor;
    request.httpMethod = @"GET";
    
    // Dispatch the request.
    [request send];
}

@end
