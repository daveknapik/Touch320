//
//  NewsItem.h
//  Touch
//
//  Created by Dave Knapik on 11/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#define kNewsItemTitleKey		@"title"
#define kNewsItemDescriptionKey	@"description"
#define kNewsItemLinkKey		@"link"
#define kNewsItemPubDateKey		@"pubDate"

#import <Foundation/Foundation.h>


@interface NewsItem : NSObject {
	NSString	*title;
	NSString	*description;
	NSString	*link;
	NSString	*pubDate;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSString *link;
@property (nonatomic, retain) NSString *pubDate;

+ (id)newsItemWithTitle:(NSString *)title
			description:(NSString *)description 
				   link:(NSString *)link 
				pubDate:(NSString *)pubDate;

- (id)initWithTitle:(NSString *)title
		description:(NSString *)description 
			   link:(NSString *)link 
			pubDate:(NSString *)pubDate;

@end
