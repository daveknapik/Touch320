//
//  NewsDataSource.m
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsDataSource.h"
#import "NewsTableItem.h"
#import "NewsTableItemCell.h"
#import "NewsItemViewController.h"

@implementation NewsDataSource

- (id)initWithModel {
	if( [self init] ) {
		_newsModel = [[NewsModel alloc] init];
	}
	
	NSLog(@"init data source");
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_newsModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _newsModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	//NSLog(@"News Items: %@", _newsModel.newsItems);
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSArray *keys = [_newsModel.newsItems allKeys];
	
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];

	
	for (id key in sortedKeys) {
		NSMutableDictionary* theItem = [_newsModel.newsItems objectForKey:key];
		
		NSString* title = [theItem objectForKey:@"title"];
		NSString* link = [theItem objectForKey:@"link"];
		
		if( !TTIsEmptyString(title) ) {
			
			[items addObject:[NewsTableItem
							  itemWithText: title
							  title: title
							  link: link]];
		}
	} 
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource 

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object { 
	if ([object isKindOfClass:[NewsTableItem class]]) { 
		return [NewsTableItemCell class]; 
	} 
	else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
} 

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath { 
	cell.accessoryType = UITableViewCellAccessoryNone;
} 

@end
