//
//  NewsViewController.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsDataSource.h"
#import "NewsTableItem.h"
#import "Touch320AppDelegate.h"

@implementation NewsViewController

-(id) initWithTabBar:(NSString *)placeholder {
	if (self = [self init]) {
		//this is the label on the tab button itself
		self.title = @"News";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"News"
																				style:UIBarButtonItemStyleBordered
																				target:nil
																				action:nil] autorelease];
		
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.tabBarItem.image = [UIImage imageNamed:@"news"];
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
	nb.tintColor = [UIColor blackColor];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"news-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"news-nav"].CGImage;
	}	
}

- (void)createModel {
	self.dataSource = [[[NewsDataSource alloc] initWithModel] autorelease];
	NSLog(@"model created");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	if ([object isKindOfClass:[NewsTableItem class]]) { 
		NSDictionary *query = [NSDictionary
							   dictionaryWithObjectsAndKeys:
							   [object link], @"link",
							   [object title], @"title",
							   [object description], @"description",
							   [object pubDate], @"pubDate",
							   nil];
		//[[TTNavigator navigator] openURL:@"tt://newsItem/1" query:query animated:YES]; 
		[[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"tt://newsItem/1"] applyQuery:query] applyAnimated:YES]];
	}
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
