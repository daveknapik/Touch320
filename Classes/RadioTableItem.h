//
//  RadioTableItem.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>

@interface RadioTableItem : TTTableSubtitleItem {
	NSString* _title;
	NSString* _author;
	NSString* _summary;
	NSString* _pubDate;
	NSString* _link;
	NSString* _episode_duration;
}

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* summary;
@property (nonatomic, copy) NSString* pubDate;
@property (nonatomic, copy) NSString* link;
@property (nonatomic, copy) NSString* episode_duration;

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			author:(NSString*)author 
		  subtitle:(NSString*)subtitle
		   summary:(NSString*)summary
		   pubDate:(NSString*)pubDate
			  link:(NSString*)link
  episode_duration:(NSString*)episode_duration;

@end
