//
//  ImageGalleryPhotoSource.h
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "FlickrJSONResponse.h"

@interface ImageGalleryPhotoSource : TTURLRequestModel <TTPhotoSource> {
    NSString* _title;
	NSArray* _photos;
	FlickrJSONResponse* responseProcessor;
	NSUInteger page;
}

@end