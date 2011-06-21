//
//  FlickrJSONResponse.m
//
//  based on http://github.com/klazuka/TTRemoteExamples

#import "FlickrJSONResponse.h"
#import "ImageGalleryPhoto.h"
#import "Touch320AppDelegate.h"
#import "NSString+SBJSON+Rails.h"

@implementation FlickrJSONResponse
@synthesize objects, totalObjectsAvailableOnServer;

- (id)init {
	objects = [[NSMutableArray alloc] init];
	return self;
}

- (NSError*)request:(TTURLRequest*)request processResponse:(NSHTTPURLResponse*)response data:(id)data
{
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
    NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Parse the JSON data that we retrieved from the server.
    NSDictionary *json = [responseBody JSONValue];
    [responseBody release];
    
    // Drill down into the JSON object to get the parts
    // that we're actually interested in.
    NSDictionary *root = [json objectForKey:@"photoset"];
    totalObjectsAvailableOnServer = [[root objectForKey:@"total"] integerValue];
	
    // Create the ImageGalleryPhotos
    NSArray *results = [root objectForKey:@"photo"];
    for (NSDictionary *rawResult in results) {        
		NSString* smallURL = [rawResult objectForKey:@"url_t"];
		NSString* title = [rawResult objectForKey:@"title"];
		
		if (appDelegate.imageSize == @"large") {
			NSString* bigURL = [rawResult objectForKey:@"url_l"];
			CGSize bigSize = CGSizeMake([[rawResult objectForKey:@"width_l"] floatValue],
										[[rawResult objectForKey:@"height_l"] floatValue]);	
			ImageGalleryPhoto* photo = [[[ImageGalleryPhoto alloc] initWithURL:bigURL smallURL:smallURL size:bigSize caption:title] autorelease];

			[self.objects addObject:photo];
		}
		else {
			NSString* bigURL = [rawResult objectForKey:@"url_z"];
			CGSize bigSize = CGSizeMake([[rawResult objectForKey:@"width_z"] floatValue],
										[[rawResult objectForKey:@"height_z"] floatValue]);
			ImageGalleryPhoto* photo = [[[ImageGalleryPhoto alloc] initWithURL:bigURL smallURL:smallURL size:bigSize caption:title] autorelease];

			[self.objects addObject:photo];
		}
    }
    
    return nil;
}


@end
