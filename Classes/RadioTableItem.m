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
			episode_duration = _episode_duration,
			title_label = _title_label,
			subtitle_label = _subtitle_label;

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			author:(NSString*)author 
		  subtitle:(NSString*)subtitle 
		   summary:(NSString*)summary
		   pubDate:(NSString*)pubDate
			  link:(NSString*)link 
  episode_duration:(NSString*)episode_duration
	   title_label:(NSString*)title_label
	subtitle_label:(NSString*)subtitle_label { 
	RadioTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = @""; 
	item.title = @""; 
	item.author = author;
	item.subtitle = @"";
	item.summary = summary;
	item.pubDate = pubDate;
	item.link = link;
	item.episode_duration = episode_duration;
	item.title_label = title_label;
	item.subtitle_label = subtitle_label;
	
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
		_episode_duration = nil;
		_title_label = nil;
		_subtitle_label = nil;
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
	TT_RELEASE_SAFELY(_episode_duration);
	TT_RELEASE_SAFELY(_title_label);
	TT_RELEASE_SAFELY(_subtitle_label);
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
		self.episode_duration = [decoder decodeObjectForKey:@"episode_duration"];
		self.title_label = [decoder decodeObjectForKey:@"title_label"];
		self.subtitle_label = [decoder decodeObjectForKey:@"subtitle_label"];
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
	
	if (self.episode_duration) { 
		[encoder encodeObject:self.episode_duration forKey:@"episode_duration"]; 
	}
	
	if (self.title_label) { 
		[encoder encodeObject:self.title_label forKey:@"title_label"]; 
	}
	
	if (self.subtitle_label) { 
		[encoder encodeObject:self.subtitle_label forKey:@"subtitle_label"]; 
	}
} 


@end
