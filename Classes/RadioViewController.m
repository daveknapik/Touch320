//
//  RadioViewController.m
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RadioViewController.h"
#import "RadioDataSource.h"

@implementation RadioViewController

-(id) initWithTabBar:(NSString *)placeholder {
	if ((self = [self init])) {
		//this is the label on the tab button itself
		self.title = @"Radio";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Radio"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.tabBarItem.image = [UIImage imageNamed:@"radio"];
	}
	
	return self;
}

- (id)init {
	if ((self = [super init])) {
		self.tableViewStyle = UITableViewStylePlain;
		self.variableHeightRows = YES;
	}
	
	return self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	UINavigationBar *nb = self.navigationController.navigationBar;
	nb.tintColor = [UIColor colorWithRed:176/255.0 green:169/255.0 blue:18/255.0 alpha:1];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"radio-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"radio-nav"].CGImage;
	}	
}

- (void)createModel {
	self.dataSource = [[[RadioDataSource alloc] initWithModel] autorelease];
	NSLog(@"radio model created");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	NSDictionary *query = [NSDictionary
						   dictionaryWithObjectsAndKeys:
						   [object author], @"author",
						   [object title], @"title",
						   [object subtitle], @"subtitle",
						   [object summary], @"summary",
						   [object pubDate], @"pubDate",
						   [object link], @"link",
						   [object episode_duration], @"episode_duration",
						   [object title_label], @"title_label",
						   [object subtitle_label], @"subtitle_label",
						   nil];
	
	//[[TTNavigator navigator] openURL:@"tt://radioItem/1" query:query animated:YES]; 
	
	/*NSLog(@"object author: %@",[object author]);
	NSLog(@"object title: %@",[object title]);
	NSLog(@"object subtitle: %@",[object subtitle]);
	NSLog(@"object summary: %@",[object summary]);
	NSLog(@"object pubDate: %@",[object pubDate]);
	NSLog(@"object link: %@",[object link]);
	NSLog(@"object episode_duration: %@",[object episode_duration]);
	NSLog(@"query: %@",query);*/
	
	[[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"tt://radioItem/1"] applyQuery:query] applyAnimated:YES]];
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
