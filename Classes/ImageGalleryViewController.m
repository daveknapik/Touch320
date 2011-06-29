//
//  ImageGalleryViewController.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGalleryViewController.h"
#import "ImageGalleryPhotoSource.h"
#import "ImageGalleryPhotoViewController.h"

@implementation ImageGalleryViewController

-(id) initWithTabBar:(NSString *)placeholder {
	if ([self init]) {
		//this is the label on the tab button itself
		self.title = @"Images";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Images"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.hidesBottomBarWhenPushed = NO;
		
		self.tabBarItem.image = [UIImage imageNamed:@"images"];
	}
	
	return self;
}

- (void)updateTableLayout {
	self.tableView.contentInset = UIEdgeInsetsZero;
	self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
	
}

- (TTPhotoViewController *)createPhotoViewController
{
	ImageGalleryPhotoViewController *imageGalleryPhotoViewController = [[[ImageGalleryPhotoViewController alloc] init] autorelease];
	
	[imageGalleryPhotoViewController.navigationItem.rightBarButtonItem setTitle:@"Save"]; 
	
    return imageGalleryPhotoViewController;
	
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	UINavigationBar *nb = self.navigationController.navigationBar;
	nb.tintColor = [UIColor colorWithRed:195/255.0 green:54/255.0 blue:37/255.0 alpha:1];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"images-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"images-nav"].CGImage;
	}	
}

- (void)viewDidLoad {
	ImageGalleryPhotoSource *imageGalleryPhotoSource = [[ImageGalleryPhotoSource alloc] init];
	self.photoSource = imageGalleryPhotoSource;
	
	self.navigationBarStyle = UIBarStyleDefault; 
	self.navigationBarTintColor	= [UIColor blackColor];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);	
}

- (void)dealloc {
    [super dealloc];
}

@end