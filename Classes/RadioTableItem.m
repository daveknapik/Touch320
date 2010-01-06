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
			summary = _summary,
			pubDate = _pubDate,
			link = _link,
			duration = _duration;

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			author:(NSString*)author 
		  subtitle:(NSString*)subtitle 
		   summary:(NSString*)summary
		   pubDate:(NSString*)pubDate
			  link:(NSString*)link
		  duration:(NSString*)duration { 
	RadioTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title; 
	item.author = author;
	item.subtitle = subtitle;
	item.summary = summary;
	item.pubDate = pubDate;
	item.link = link;
	item.duration = duration;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_author = nil;
		_subtitle = nil;
		_summary = nil;
		_pubDate = nil;
		_link = nil;
		_duration = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_author); 
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_summary);
	TT_RELEASE_SAFELY(_pubDate);
	TT_RELEASE_SAFELY(_link);
	TT_RELEASE_SAFELY(_duration);
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"];
		self.author = [decoder decodeObjectForKey:@"author"];
		self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
		self.summary = [decoder decodeObjectForKey:@"summary"];
		self.pubDate = [decoder decodeObjectForKey:@"pubDate"];
		self.link = [decoder decodeObjectForKey:@"link"];
		self.duration = [decoder decodeObjectForKey:@"duration"];
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
	
	if (self.summary) { 
		[encoder encodeObject:self.summary forKey:@"summary"]; 
	}
	
	if (self.pubDate) { 
		[encoder encodeObject:self.pubDate forKey:@"pubDate"]; 
	}
	
	if (self.link) { 
		[encoder encodeObject:self.link forKey:@"link"]; 
	}
	
	if (self.duration) { 
		[encoder encodeObject:self.duration forKey:@"duration"]; 
	}
} 


@end
