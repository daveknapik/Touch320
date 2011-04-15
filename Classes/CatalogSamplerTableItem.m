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
			release_duration = _release_duration,
			track_listing = _track_listing,
			title_label = _title_label,
			subtitle_label = _subtitle_label;

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
  release_duration:(NSString*)release_duration
	 track_listing:(NSString*)track_listing
	   title_label:(NSString*)title_label
	subtitle_label:(NSString*)subtitle_label
{
	CatalogSamplerTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.text = @""; 
	item.title = @""; 
	item.subtitle = @"";
	item.artist = artist;
	item.catalogNumber = catalogNumber;
	item.release_description = release_description;
	item.cover_art_url = cover_art_url;
	item.mp3_sample_url = mp3_sample_url;
	item.release_url = release_url;
	item.itunes_url = itunes_url;
	item.release_duration = release_duration;
	item.track_listing = track_listing;
	item.title_label = title_label;
	item.subtitle_label = subtitle_label;
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_title = nil; 
		_subtitle = nil;
		_artist = nil;
		_catalogNumber = nil;
		_release_description = nil;
		_cover_art_url = nil;
		_mp3_sample_url = nil;
		_release_url = nil;
		_itunes_url = nil;
		_release_duration = nil;
		_track_listing = nil;
		_title_label = nil;
		_subtitle_label = nil;
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
	TT_RELEASE_SAFELY(_release_duration); 
	TT_RELEASE_SAFELY(_track_listing); 
	TT_RELEASE_SAFELY(_title_label);
	TT_RELEASE_SAFELY(_subtitle_label);
	
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
		self.release_duration = [decoder decodeObjectForKey:@"release_duration"];
		self.track_listing = [decoder decodeObjectForKey:@"track_listing"];
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
	
	if (self.release_duration) { 
		[encoder encodeObject:self.release_duration forKey:@"release_duration"]; 
	} 
	
	if (self.track_listing) { 
		[encoder encodeObject:self.track_listing forKey:@"track_listing"]; 
	} 
	
	if (self.title_label) { 
		[encoder encodeObject:self.title_label forKey:@"title_label"]; 
	} 
	
	if (self.subtitle_label) { 
		[encoder encodeObject:self.subtitle_label forKey:@"subtitle_label"]; 
	} 
} 

@end
