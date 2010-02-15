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
			author = _author, 
recipe_description = _recipe_description; 

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
		  subtitle:(NSString*)subtitle 
			author:(NSString*)author 
recipe_description:(NSString*)recipe_description { 
	RecipeBookTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title;
	item.subtitle = subtitle;
	item.author = author;
	item.recipe_description = recipe_description;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_subtitle = nil;
		_author = nil;
		_recipe_description = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_author);
	TT_RELEASE_SAFELY(_recipe_description);
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"]; 
		self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
		self.author = [decoder decodeObjectForKey:@"author"];
		self.recipe_description = [decoder decodeObjectForKey:@"recipe_description"];
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
	
	if (self.recipe_description) { 
		[encoder encodeObject:self.recipe_description forKey:@"recipe_description"]; 
	}
} 


@end