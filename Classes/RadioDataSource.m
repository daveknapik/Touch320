//
//  RadioDataSource.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioDataSource.h"
#import "RadioTableItem.h"
#import "RadioTableItemCell.h"

@implementation RadioDataSource

- (id)initWithModel {
	if( [self init] ) {
		_radioModel = [[RadioModel alloc] init];
	}
	
	NSLog(@"init radio data source");
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_radioModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _radioModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	//NSLog(@"Radio Items: %@", _radioModel.radioItems);
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSArray *keys = [_radioModel.radioItems allKeys];
	
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
	
	for (id key in sortedKeys) {
		NSMutableDictionary* theItem = [_radioModel.radioItems objectForKey:key];
		
		NSString* title = [theItem objectForKey:@"title"];
		NSString* author = [theItem objectForKey:@"author"];
		NSString* subtitle = [theItem objectForKey:@"subtitle"];
		NSString* summary = [theItem objectForKey:@"summary"];
		NSString* pubDate = [theItem objectForKey:@"pubDate"];
		NSString* link = [theItem objectForKey:@"guid"];
		NSString* duration = [theItem objectForKey:@"duration"];
		
		if( !TTIsEmptyString(title) ) {
			[items addObject:[RadioTableItem
							  itemWithText: title
							  title: title
							  author: author
							  subtitle: subtitle
							  summary: summary
							  pubDate: pubDate
							  link: link
							  duration: duration]];
		}
	} 
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTTableViewDataSource 

- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object { 
	if ([object isKindOfClass:[RadioTableItem class]]) { 
		return [RadioTableItemCell class]; 
	} 
	else { 
		return [super tableView:tableView cellClassForObject:object]; 
	}
} 

- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath { 
	cell.accessoryType = UITableViewCellAccessoryNone;
} 

@end
