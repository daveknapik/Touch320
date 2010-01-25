//
//  CatalogSamplerViewController.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CatalogSamplerViewController.h"
#import "CatalogSamplerDataSource.h"

@implementation CatalogSamplerViewController

-(id) initWithTabBar:(NSString *)placeholder {
	if (self = [self init]) {
		//this is the label on the tab button itself
		self.title = @"Catalogue";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"Catalogue";
		
		self.navigationBarStyle = UIBarStyleDefault; 
		self.navigationBarTintColor	= [UIColor blackColor];
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
		self.tableViewStyle = UITableViewStylePlain;
	}
	
	return self;
}

- (void)createModel {
	self.dataSource = [[[CatalogSamplerDataSource alloc] initWithModel] autorelease];
	NSLog(@"createModel invoked in CatalogSamplerViewController");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	NSDictionary *query = [NSDictionary
						   dictionaryWithObjectsAndKeys:
						   [object title], @"title",
						   [object subtitle], @"subtitle",
						   [object artist], @"artist",
						   [object description], @"description",
						   [object catalogNumber], @"catalogNumber",
						   [object release_url], @"release_url",
						   [object mp3_sample_url], @"mp3_sample_url",
						   [object cover_art_url], @"cover_art_url",
						   [object itunes_url], @"itunes_url",
						   [object duration], @"duration",
						   [object track_listing], @"track_listing",
						   [object reviews], @"reviews",
						   nil];
	[[TTNavigator navigator] openURL:@"tt://catalogItem/1" query:query animated:YES]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}

@end
