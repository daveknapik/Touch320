//
//  ImageGalleryViewController.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "ImageGalleryPhotoSource.h"
#import "FlickrSearchResultsModel.h"
#import "MockPhotoSource.h"

@implementation ImageGalleryViewController

-(id) initWithTabBar {
	if ([self init]) {
		//this is the label on the tab button itself
		self.title = @"Listening Eye";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"Listening Eye";
		
		self.navigationBarTintColor	= [UIColor blackColor];
		self.hidesBottomBarWhenPushed = NO;
	}
	
	return self;
}

 - (void)viewDidLoad {
	FlickrSearchResultsModel *model = [[[FlickrSearchResultsModel alloc] init] autorelease];
	photoSource = [[ImageGalleryPhotoSource alloc] initWithModel:model];
	[model release];
	 
	/*self.photoSource = [[MockPhotoSource alloc]
						initWithType:MockPhotoSourceNormal
						title:self.title
						photos:[[NSArray alloc] initWithObjects:
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3246/2957580101_33c799fc09_o.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3246/2957580101_d63ef56b15_t.jpg"
								  size:CGSizeMake(960, 1280)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3444/3223645618_13fe36887a_o.jpg"
								  smallURL:@"http://farm4.static.flickr.com/3444/3223645618_f5e2fa7fea_t.jpg"
								  size:CGSizeMake(320, 480)
								  caption:@"These are the wood tiles that we had installed after the accident."] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123.jpg?v=0"
								  smallURL:@"http://farm2.static.flickr.com/1124/3164979509_bcfdd72123_t.jpg"
								  size:CGSizeMake(320, 480)
								  caption:@"A hike."] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b.jpg?v=0"
								  smallURL:@"http://farm4.static.flickr.com/3106/3203111597_d849ef615b_t.jpg"
								  size:CGSizeMake(320, 480)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d.jpg?v=0"
								  smallURL:@"http://farm4.static.flickr.com/3099/3164979221_6c0e583f7d_t.jpg"
								  size:CGSizeMake(320, 480)] autorelease],
								[[[MockPhoto alloc]
								  initWithURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2.jpg?v=0"
								  smallURL:@"http://farm4.static.flickr.com/3081/3164978791_3c292029f2_t.jpg"
								  size:CGSizeMake(320, 480)] autorelease],
								
								nil
								]
						
						photos2:nil
						//  photos2:[[NSArray alloc] initWithObjects:
						//    [[[MockPhoto alloc]
						//      initWithURL:@"http://farm4.static.flickr.com/3280/2949707060_e639b539c5_o.jpg"
						//      smallURL:@"http://farm4.static.flickr.com/3280/2949707060_8139284ba5_t.jpg"
						//      size:CGSizeMake(800, 533)] autorelease],
						//    nil]
						]; */
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)dealloc {
	[photoSource dealloc];
    [super dealloc];
}

@end