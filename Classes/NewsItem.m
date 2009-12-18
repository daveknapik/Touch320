//
//  NewsItem.m
//  Touch
//
//  Created by Dave Knapik on 11/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsItem.h"


@implementation NewsItem
@synthesize title;
@synthesize description;
@synthesize link;
@synthesize pubDate;

- (void)dealloc {
	[title dealloc];
	[description dealloc];
	[link dealloc];
	[pubDate dealloc];
	[super dealloc];
}

+ (id)newsItemWithTitle:(NSString *)theTitle
			description:(NSString *)theDescription 
				   link:(NSString *)theLink 
				pubDate:(NSString *)thePubDate
{
    NewsItem *newsItem = [[self alloc] initWithTitle:(NSString *)theTitle
										 description:(NSString *)theDescription 
												link:(NSString *)theLink 
											 pubDate:(NSString *)thePubDate];
    return [newsItem autorelease];
}

- (id)init
{
    return [self initWithTitle:nil 
				   description:nil
						  link:nil 
					   pubDate:nil];
}

- (id)initWithTitle:(NSString *)theTitle 
		description:(NSString *)theDescription 
			   link:(NSString *)theLink 
			pubDate:(NSString *)thePubDate;
{
    [self setTitle:(theTitle != nil ? theTitle : @"")];
	[self setDescription:(theDescription != nil ? theDescription : @"")];
    [self setLink:(theLink != nil ? theLink : @"")];
	[self setPubDate:(thePubDate != nil ? thePubDate : @"")];
    
    return self;
}


@end
