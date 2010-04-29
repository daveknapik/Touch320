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
	NSString* _duration;
	NSString* _track_listing;
}

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* catalogNumber;
@property (nonatomic, copy) NSString* release_description;
@property (nonatomic, copy) NSString* cover_art_url;
@property (nonatomic, copy) NSString* mp3_sample_url;
@property (nonatomic, copy) NSString* release_url;
@property (nonatomic, copy) NSString* itunes_url;
@property (nonatomic, copy) NSString* duration;
@property (nonatomic, copy) NSString* track_listing;

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
	 track_listing:(NSString*)track_listing;

@end

