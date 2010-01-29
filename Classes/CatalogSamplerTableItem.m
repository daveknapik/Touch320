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
			artist = _artist,
			catalogNumber = _catalogNumber,
			release_description = _release_description,
			cover_art_url = _cover_art_url,
			mp3_sample_url = _mp3_sample_url,
			release_url = _release_url,
			itunes_url = _itunes_url,
			duration = _duration,
			track_listing = _track_listing,
			reviews = _reviews;

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
		  subtitle:(NSString*)subtitle
			artist:(NSString*)artist
	 catalogNumber:(NSString*)catalogNumber 
release_description:(NSString*)release_description
	 cover_art_url:(NSString*)cover_art_url
	mp3_sample_url:(NSString*)mp3_sample_url
	   release_url:(NSString*)release_url
		itunes_url:(NSString*)itunes_url
		  duration:(NSString*)duration
	 track_listing:(NSString*)track_listing
		   reviews:(NSString*)reviews 
{
	CatalogSamplerTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = text; 
	item.title = title; 
	item.subtitle = subtitle;
	item.artist = artist;
	item.catalogNumber = catalogNumber;
	item.release_description = release_description;
	item.cover_art_url = cover_art_url;
	item.mp3_sample_url = mp3_sample_url;
	item.release_url = release_url;
	item.itunes_url = itunes_url;
	item.duration = duration;
	item.track_listing = track_listing;
	item.reviews = reviews;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_subtitle = nil;
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_title); 
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_artist); 
	TT_RELEASE_SAFELY(_catalogNumber); 
	TT_RELEASE_SAFELY(_release_description); 
	TT_RELEASE_SAFELY(_cover_art_url); 
	TT_RELEASE_SAFELY(_mp3_sample_url); 
	TT_RELEASE_SAFELY(_release_url); 
	TT_RELEASE_SAFELY(_itunes_url); 
	TT_RELEASE_SAFELY(_duration); 
	TT_RELEASE_SAFELY(_track_listing); 
	TT_RELEASE_SAFELY(_reviews);
	
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.title = [decoder decodeObjectForKey:@"title"];
		self.subtitle = [decoder decodeObjectForKey:@"subtitle"];
		self.artist = [decoder decodeObjectForKey:@"artist"];
		self.catalogNumber = [decoder decodeObjectForKey:@"catalogNumber"];
		self.release_description = [decoder decodeObjectForKey:@"release_description"];
		self.cover_art_url = [decoder decodeObjectForKey:@"cover_art_url"];
		self.mp3_sample_url = [decoder decodeObjectForKey:@"mp3_sample_url"];
		self.release_url = [decoder decodeObjectForKey:@"release_url"];
		self.itunes_url = [decoder decodeObjectForKey:@"itunes_url"];
		self.duration = [decoder decodeObjectForKey:@"duration"];
		self.track_listing = [decoder decodeObjectForKey:@"track_listing"];
		self.reviews = [decoder decodeObjectForKey:@"reviews"];
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
	
	if (self.artist) { 
		[encoder encodeObject:self.artist forKey:@"artist"]; 
	} 
	
	if (self.catalogNumber) { 
		[encoder encodeObject:self.catalogNumber forKey:@"catalogNumber"]; 
	} 
	
	if (self.release_description) { 
		[encoder encodeObject:self.release_description forKey:@"release_description"]; 
	} 
	
	if (self.cover_art_url) { 
		[encoder encodeObject:self.cover_art_url forKey:@"cover_art_url"]; 
	} 
	
	if (self.mp3_sample_url) { 
		[encoder encodeObject:self.mp3_sample_url forKey:@"mp3_sample_url"]; 
	} 
	
	if (self.release_url) { 
		[encoder encodeObject:self.release_url forKey:@"release_url"]; 
	} 
	
	if (self.itunes_url) { 
		[encoder encodeObject:self.itunes_url forKey:@"itunes_url"]; 
	} 
	
	if (self.duration) { 
		[encoder encodeObject:self.duration forKey:@"duration"]; 
	} 
	
	if (self.track_listing) { 
		[encoder encodeObject:self.track_listing forKey:@"track_listing"]; 
	} 
	
	if (self.reviews) { 
		[encoder encodeObject:self.reviews forKey:@"reviews"]; 
	} 
} 

@end
