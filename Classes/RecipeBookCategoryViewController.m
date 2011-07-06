//
//  RecipeBookCategoryViewController.m
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookCategoryViewController.h"
#import "RecipeBookCategoryDataSource.h"
#import "RecipeBookCategoryTableItem.h"


@implementation RecipeBookCategoryViewController

-(id) initWithTabBar:(NSString *)placeholder {
	if ((self = [self init])) {
		//this is the label on the tab button itself
		self.title = @"Recipes";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Recipes"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.tabBarItem.image = [UIImage imageNamed:@"recipes"];
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
	nb.tintColor = [UIColor colorWithRed:32/255.0 green:70/255.0 blue:117/255.0 alpha:1];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"recipes-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"recipes-nav"].CGImage;
	}
}

- (void)createModel {
	self.dataSource = [[[RecipeBookCategoryDataSource alloc] initWithModel] autorelease];
	NSLog(@"recipe book model created");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	if ([object isKindOfClass:[RecipeBookCategoryTableItem class]]) { 
		NSDictionary *query = [NSDictionary
							   dictionaryWithObjectsAndKeys: [object title], @"title", nil];
		//[[TTNavigator navigator] openURL:@"tt://recipes/1" query:query animated:YES]; 
		[[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"tt://recipes/1"] applyQuery:query] applyAnimated:YES]];
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