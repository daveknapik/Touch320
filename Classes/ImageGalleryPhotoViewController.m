//
//  ImageGalleryPhotoViewController.m
//  ALThumbs3
//
//  Created by Dave Knapik on 21/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGalleryPhotoViewController.h"
#define degreesToRadian(x) (M_PI * (x) / 180.0)


@implementation ImageGalleryPhotoViewController

- (id)initWithPhoto:(id<TTPhoto>)photo {
	return self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:NO];
    [[UIDevice currentDevice] setOrientation:UIInterfaceOrientationLandscapeRight];
}

- (void)updateChrome { 
	[super updateChrome];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(savePhoto)] autorelease]; 
}

- (void)savePhoto {
	UIActionSheet *actionSheet = [[UIActionSheet alloc] 
                                  initWithTitle:nil
                                  delegate:self 
                                  cancelButtonTitle:@"Cancel" 
                                  destructiveButtonTitle:@"Save to Camera Roll" 
                                  otherButtonTitles:nil]; 
    [actionSheet showInView:self.view]; 
    [actionSheet release]; 
	
	
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex != [actionSheet cancelButtonIndex]) { 
		TTURLRequest *request = [TTURLRequest request];
		request.urlPath = [self.centerPhoto URLForVersion:TTPhotoVersionLarge];
		TTURLImageResponse *response = [[[TTURLImageResponse alloc] init] autorelease];
		request.response = response;
		if ([request send]) {
			UIImage *image = response.image;
			UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
		} 
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);	
}

@end
