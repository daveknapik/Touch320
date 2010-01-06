//
//  RadioTableItem.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioTableItem.h"

@implementation RadioTableItem

@synthesize title = _title, 
			author = _author,
			subtitle = _subtitle;

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			author:(NSString*)author 
		  subtitle:(NSString*)subtitle{ 
	RadioTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title; 
	item.author = author;
	item.subtitle = subtitle;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_author = nil;
		_subtitle = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_author); 
	TT_RELEASE_SAFELY(_subtitle);
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"];
		self.author = [decoder decodeObjectForKey:@"author"];
		self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
	} 
	
	return self;
} 

- (void)encodeWithCoder:(NSCoder*)encoder { 
	[super encodeWithCoder:encoder]; 
	
	if (self.title) { 
		[encoder encodeObject:self.title forKey:@"title"]; 
	} 
	
	if (self.author) { 
		[encoder encodeObject:self.author forKey:@"author"]; 
	}
	
	if (self.subtitle) { 
		[encoder encodeObject:self.subtitle forKey:@"subtitle"]; 
	}
} 


@end
