//
//  CatalogSamplerTableItem.m
//  Touch320
//
//  Created by Dave Knapik on 15/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CatalogSamplerTableItem.h"


@implementation CatalogSamplerTableItem

@synthesize title = _title, 
thoughts = _thoughts;

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			thoughts:(NSString*)thoughts 
		  subtitle:(NSString*)subtitle  { 
	CatalogSamplerTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title; 
	item.thoughts = thoughts;
	item.subtitle = subtitle;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_thoughts = nil;
		_subtitle = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_thoughts); 
	TT_RELEASE_SAFELY(_subtitle);	
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"];
		self.thoughts = [decoder decodeObjectForKey:@"thoughts"];
		self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
	} 
	
	return self;
} 

- (void)encodeWithCoder:(NSCoder*)encoder { 
	[super encodeWithCoder:encoder]; 
	
	if (self.title) { 
		[encoder encodeObject:self.title forKey:@"title"]; 
	} 
	
	if (self.thoughts) { 
		[encoder encodeObject:self.thoughts forKey:@"thoughts"]; 
	}
	
	if (self.subtitle) { 
		[encoder encodeObject:self.subtitle forKey:@"subtitle"]; 
	}
} 

@end
