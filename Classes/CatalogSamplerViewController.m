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
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Catalogue"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.tabBarItem.image = [UIImage imageNamed:@"catalog"];
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
		self.tableViewStyle = UITableViewStylePlain;
		self.variableHeightRows = YES;
	}
	
	return self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	UINavigationBar *nb = self.navigationController.navigationBar;
	nb.tintColor = [UIColor colorWithRed:82/255.0 green:96/255.0 blue:45/255.0 alpha:1];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"catalog-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"catalog-nav"].CGImage;
	}	
}

- (void)createModel {
	self.dataSource = [[[CatalogSamplerDataSource alloc] initWithModel] autorelease];
	NSLog(@"createModel invoked in CatalogSamplerViewController");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	NSLog(@"selected catalog item");
	NSLog([object title]);
	NSLog([object subtitle]);
	NSLog([object artist]);
	NSLog([object release_description]);
	NSLog([object catalogNumber]);
	NSLog([object release_url]);
	NSLog([object mp3_sample_url]);
	NSLog([object cover_art_url]);
	NSLog([object itunes_url]);
	NSLog([object track_listing]);
	NSLog([object release_duration]);
	
	NSDictionary *query = [NSDictionary
						   dictionaryWithObjectsAndKeys:
						   [object title_label], @"title",
						   [object subtitle_label], @"subtitle",
						   [object artist], @"artist",
						   [object release_description], @"release_description",
						   [object catalogNumber], @"catalogNumber",
						   [object release_url], @"release_url",
						   [object mp3_sample_url], @"mp3_sample_url",
						   [object cover_art_url], @"cover_art_url",
						   [object itunes_url], @"itunes_url",
						   [object track_listing], @"track_listing",
						   [object release_duration], @"release_duration",
						   nil];
	//[[TTNavigator navigator] openURL:@"tt://catalogItem/1" query:query animated:YES]; 
	[[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"tt://catalogItem/1"] applyQuery:query] applyAnimated:YES]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
