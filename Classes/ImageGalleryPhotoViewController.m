//
//  ImageGalleryPhotoViewController.m
//  ALThumbs3
//
//  Created by Dave Knapik on 21/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGalleryPhotoViewController.h"


@implementation ImageGalleryPhotoViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation !=
			UIInterfaceOrientationPortraitUpsideDown);
	
} 

@end
