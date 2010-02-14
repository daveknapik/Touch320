//
//  RecipeBookCategoryDataSource.m
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookCategoryDataSource.h"
#import "RecipeBookCategoryTableItem.h"
#import "RecipeBookCategoryTableItemCell.h"

@implementation RecipeBookCategoryDataSource

- (id)initWithModel {
	if( [self init] ) {
		_recipeBookCategoryModel = [[RecipeBookCategoryModel alloc] init];
	}
	
	NSLog(@"init recipe book data source");
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipeBookCategoryModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _recipeBookCategoryModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	//NSLog(@"Recipe Book Items: %@", _recipeBookCategoryModel.newsItems);
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSArray *keys = [_recipeBookCategoryModel.recipes allKeys];
	
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
	
	
	for (id key in sortedKeys) {
		NSMutableDictionary* theItem = [_recipeBookCategoryModel.recipes objectForKey:key];
		
		NSString* title = [theItem objectForKey:@"title"];
		
		if( !TTIsEmptyString(title) ) {
			
			[items addObject:[RecipeBookCategoryTableItem
							  itemWithText: title
							  title: title]];
		}
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource 

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object { 
	if ([object isKindOfClass:[RecipeBookCategoryTableItem class]]) { 
		return [RecipeBookCategoryTableItemCell class]; 
	} 
	else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
} 

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath { 
	cell.accessoryType = UITableViewCellAccessoryNone;
} 

@end