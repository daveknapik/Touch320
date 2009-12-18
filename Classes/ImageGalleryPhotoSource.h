//
//  ImageGalleryPhotoSource.h
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "FlickrSearchResultsModel.h"

@interface ImageGalleryPhotoSource : NSObject <TTPhotoSource>
{
    FlickrSearchResultsModel *model;
    
    // Backing storage for TTPhotoSource properties.
    NSString *albumTitle;
    int totalNumberOfPhotos;    
}

- (id)initWithModel:(FlickrSearchResultsModel *)theModel;    // Designated initializer.

@end