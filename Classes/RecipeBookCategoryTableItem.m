//
//  RecipeBookCategoryTableItem.m
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookCategoryTableItem.h"


@implementation RecipeBookCategoryTableItem

@synthesize title = _title; 

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title { 
	RecipeBookCategoryTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"]; 
	} 
	
	return self;
} 

- (void)encodeWithCoder:(NSCoder*)encoder { 
	[super encodeWithCoder:encoder]; 
	
	if (self.title) { 
		[encoder encodeObject:self.title forKey:@"title"]; 
	} 
} 


@end
