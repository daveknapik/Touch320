//
//  RecipeBookDataSource.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookDataSource.h"
#import "RecipeBookTableItem.h"
#import "RecipeBookTableItemCell.h"

@implementation RecipeBookDataSource

- (id)initWithModel:(NSString *)category {
	if( [self init] ) {
		_recipeBookModel = [[RecipeBookModel alloc] initWithCategory:category];
	}
	
	NSLog(@"init recipe book data source");
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_recipeBookModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _recipeBookModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	//NSLog(@"Recipe Book Items: %@", _recipeBookModel.newsItems);
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSArray *keys = [_recipeBookModel.recipes allKeys];
	
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
	
	
	for (id key in sortedKeys) {
		NSMutableDictionary* theItem = [_recipeBookModel.recipes objectForKey:key];
		
		NSString* title = [theItem objectForKey:@"title"];
		NSString* subtitle = [theItem objectForKey:@"excerpt"];
		
		if( !TTIsEmptyString(title) ) {
			
			[items addObject:[RecipeBookTableItem
							  itemWithText: title
							  title: title
							  subtitle: subtitle 
							  author: title]];
		}
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource 

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object { 
	if ([object isKindOfClass:[RecipeBookTableItem class]]) { 
		return [RecipeBookTableItemCell class]; 
	} 
	else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
} 

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath { 
	cell.accessoryType = UITableViewCellAccessoryNone;
} 

@end

