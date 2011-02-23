//
//  RecipeBookViewController.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookViewController.h"
#import "RecipeBookDataSource.h"

@implementation RecipeBookViewController

-(id)initWithRecipes:(NSString *)placeholder query:(NSDictionary*)query {
	if (self = [self init]) {
		//this is the label on the tab button itself
		self.title = [query objectForKey:@"title"];
		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title = [query objectForKey:@"title"];
		
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
	self.dataSource = [[[RecipeBookDataSource alloc] initWithModel:self.title] autorelease];
	NSLog(@"recipe book model created");
}

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
	NSDictionary *query = [NSDictionary
						   dictionaryWithObjectsAndKeys:
						   [object author], @"author",
						   [object subtitle], @"title",
						   [object recipe_description], @"recipe_description",
						   nil];
	//[[TTNavigator navigator] openURL:@"tt://recipeItem/1" query:query animated:YES]; 
	[[TTNavigator navigator] openURLAction:[[[TTURLAction actionWithURLPath:@"tt://recipeItem/1"] applyQuery:query] applyAnimated:YES]];
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [super dealloc];
}

@end
