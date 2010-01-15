//
//  CatalogSamplerModel.m
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CatalogSamplerModel.h"
#import "Book.h"

@implementation CatalogSamplerModel

@synthesize catalogItems = _catalogItems;

- (id)init {
	page = 1;
	
	NSMutableArray *books = [Book findAllRemote];
	self.catalogItems = books;
	
	[super init];
	return self;
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_catalogItems);
	[super dealloc];
}


@end
