//
//  RecipeBookTableItem.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookTableItem.h"


@implementation RecipeBookTableItem

@synthesize title = _title,
			author = _author; 

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
		  subtitle:(NSString*)subtitle 
			author:(NSString*)author { 
	RecipeBookTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title;
	item.subtitle = subtitle;
	item.author = author;
	
	NSLog(@"recipe title: %@",title);
	NSLog(@"recipe author: %@",author);
	NSLog(@"recipe item author: %@",item.author);
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_subtitle = nil;
		_author = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_author);
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"]; 
		self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
		self.author = [decoder decodeObjectForKey:@"author"];
	} 
	
	return self;
} 

- (void)encodeWithCoder:(NSCoder*)encoder { 
	[super encodeWithCoder:encoder]; 
	
	if (self.title) { 
		[encoder encodeObject:self.title forKey:@"title"]; 
	} 
	
	if (self.subtitle) { 
		[encoder encodeObject:self.subtitle forKey:@"subtitle"]; 
	}
	
	if (self.author) { 
		[encoder encodeObject:self.author forKey:@"author"]; 
	}
} 


@end