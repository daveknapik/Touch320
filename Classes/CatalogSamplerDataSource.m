//
//  CatalogSamplerDataSource.m
//  Touch320
//
//  Created by Dave Knapik on 26/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CatalogSamplerDataSource.h"
#import "CatalogSamplerTableItem.h"
#import "CatalogSamplerTableItemCell.h"
#import "Book.h"

@implementation CatalogSamplerDataSource

//@synthesize catalogItems = _catalogItems;

+ (NSMutableArray*)getAllCatalogItems {
	NSMutableArray *books = [Book findAllRemote];
	return books;
}

- (id)initWithModel {
	if( [self init] ) {
		_catalogSamplerModel = [[CatalogSamplerModel alloc] init];
	}
	
	NSLog(@"init catalog datasource");
	
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_catalogSamplerModel);
	
	[super dealloc];
}

- (id<TTModel>)model {
	return _catalogSamplerModel;
}

- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSLog(@"Catalog Items: %@", _catalogSamplerModel.catalogItems);
	
	Book *currentBook;
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (int x = 0; x < [_catalogSamplerModel.catalogItems count]; x++) {
		currentBook = [_catalogSamplerModel.catalogItems objectAtIndex:x];
		NSLog(@"current book title: %@", currentBook.title);
		
		NSString* title = currentBook.title;
		NSString* thoughts = currentBook.thoughts;
		
		if( !TTIsEmptyString(title) ) {
			[items addObject:[CatalogSamplerTableItem
							  itemWithText: title
							  title: title
							  thoughts: thoughts
							  subtitle: title]];
		}
	}	
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}

	///////////////////////////////////////////////////////////////////////////////////////////////////
	// TTTableViewDataSource 
	
	- (Class)tableView:(UITableView*)tableView cellClassForObject:(id)object { 
		if ([object isKindOfClass:[CatalogSamplerTableItem class]]) { 
			return [CatalogSamplerTableItemCell class]; 
		} 
		else { 
			return [super tableView:tableView cellClassForObject:object]; 
		}
	} 
	
	- (void)tableView:(UITableView*)tableView prepareCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath { 
		cell.accessoryType = UITableViewCellAccessoryNone;
	} 
	
	@end
