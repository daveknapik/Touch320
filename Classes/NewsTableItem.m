//
//  NewsTableItem.m
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsTableItem.h"


@implementation NewsTableItem

@synthesize title = _title, 
			link = _link,
			description = _description,
			pubDate = _pubDate; 

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			  link:(NSString*)link 
	   description:(NSString*)description
		   pubDate:(NSString*)pubDate{ 
	NewsTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title; 
	item.link = link;
	item.description = description;
	item.pubDate = pubDate;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_link = nil;
		_description = nil;
		_pubDate = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_link); 
	TT_RELEASE_SAFELY(_description); 
	TT_RELEASE_SAFELY(_pubDate); 
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"]; 
		self.link = [decoder decodeObjectForKey:@"link"];
		self.description = [decoder decodeObjectForKey:@"description"];
		self.pubDate = [decoder decodeObjectForKey:@"pubDate"];
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
	
	if (self.description) { 
		[encoder encodeObject:self.description forKey:@"description"]; 
	}
	
	if (self.pubDate) { 
		[encoder encodeObject:self.pubDate forKey:@"pubDate"]; 
	}
} 

@end
