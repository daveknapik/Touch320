//
//  ImageGalleryViewController.h
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "ImageGalleryPhotoSource.h"

@interface ImageGalleryViewController : TTThumbsViewController {
	ImageGalleryPhotoSource *photoSource;
}

-(id)initWithTabBar;

@end
