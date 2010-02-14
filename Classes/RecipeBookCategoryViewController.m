//
//  RecipeBookCategoryViewController.m
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookCategoryViewController.h"
#import "RecipeBookCategoryDataSource.h"


@implementation RecipeBookCategoryViewController

-(id) initWithTabBar:(NSString *)placeholder {
	if (self = [self init]) {
		//this is the label on the tab button itself
		self.title = @"Recipes";
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"Recipes";
		
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
	self.dataSource = [[[RecipeBookCategoryDataSource alloc] initWithModel] autorelease];
	NSLog(@"recipe book model created");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	NSDictionary *query = [NSDictionary
						   dictionaryWithObjectsAndKeys: [object title], @"title", nil];
	[[TTNavigator navigator] openURL:@"tt://recipes/1" query:query animated:YES]; 
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