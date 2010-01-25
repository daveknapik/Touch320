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

@implementation CatalogSamplerDataSource

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
	//NSLog(@"News Items: %@", _newsModel.newsItems);
	
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	NSArray *keys = [_catalogSamplerModel.catalogItems allKeys];
	
	NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
	
	
	for (id key in sortedKeys) {
		NSMutableDictionary* theItem = [_catalogSamplerModel.catalogItems objectForKey:key];
		
		NSString* artist = [theItem objectForKey:@"artist"];
		NSString* title = [theItem objectForKey:@"title"];
		NSString* catalogNumber = [theItem objectForKey:@"catalogue_number"];
		NSString* description = [theItem objectForKey:@"description"];
		NSString* cover_art_url = [theItem objectForKey:@"cover_art_url"];
		NSString* mp3_sample_url = [theItem objectForKey:@"mp3_sample_url"];
		NSString* release_url = [theItem objectForKey:@"release_url"];
		NSString* itunes_url = [theItem objectForKey:@"itunes_url"];
		NSString* duration = [theItem objectForKey:@"duration"];
		NSString* track_listing = [theItem objectForKey:@"track_listing"];
		NSString* reviews = [theItem objectForKey:@"reviews"];
		
		if( !TTIsEmptyString(title) ) {
			[items addObject:[CatalogSamplerTableItem
							  itemWithText: title
							  title: title
							  subtitle: artist
							  artist: artist
							  catalogNumber: catalogNumber
							  description: description
							  cover_art_url: cover_art_url
							  mp3_sample_url: mp3_sample_url
							  release_url: release_url
							  itunes_url: itunes_url
							  duration: duration
							  track_listing: track_listing
							  reviews: reviews]];
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
