//
//  CatalogSamplerTableItem.h
//  Touch320
//
//  Created by Dave Knapik on 15/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>


@interface CatalogSamplerTableItem : TTTableSubtitleItem {
	NSString* _title;
	NSString* _artist;
	NSString* _catalogNumber;
	NSString* _release_description;
	NSString* _cover_art_url;
	NSString* _mp3_sample_url;
	NSString* _release_url;
	NSString* _itunes_url;
	NSString* _release_duration;
	NSString* _track_listing;
	NSString* _title_label;
	NSString* _subtitle_label;
}

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* catalogNumber;
@property (nonatomic, copy) NSString* release_description;
@property (nonatomic, copy) NSString* cover_art_url;
@property (nonatomic, copy) NSString* mp3_sample_url;
@property (nonatomic, copy) NSString* release_url;
@property (nonatomic, copy) NSString* itunes_url;
@property (nonatomic, copy) NSString* release_duration;
@property (nonatomic, copy) NSString* track_listing;
@property (nonatomic, copy) NSString* title_label;
@property (nonatomic, copy) NSString* subtitle_label;

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
	subtitle_label:(NSString*)subtitle_label;

@end

