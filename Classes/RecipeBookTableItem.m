//
//  RecipeBookTableItem.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookTableItem.h"


@implementation RecipeBookTableItem

@synthesize title = _title, link = _link; 

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			  link:(NSString*)link { 
	RecipeBookTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title; 
	item.link = link;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_link = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_link); 
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"]; 
		self.link = [decoder decodeObjectForKey:@"link"];
	} 
	
	return self;
} 

- (void)encodeWithCoder:(NSCoder*)encoder { 
	[super encodeWithCoder:encoder]; 
	
	if (self.title) { 
		[encoder encodeObject:self.title forKey:@"title"]; 
	} 
	
	if (self.link) { 
		[encoder encodeObject:self.link forKey:@"link"]; 
	}
} 


@end