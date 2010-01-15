//
//  Book.m
//  Touch320
//
//  Created by Dave Knapik on 14/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Book.h"
#import "ObjectiveResource.h"

@implementation Book

@synthesize bookId, title, thoughts, updatedAt, createdAt;

- (void) dealloc
{
	[bookId release];
	[title release];
	[thoughts release];
	[createdAt release];
	[updatedAt release];
	[super dealloc];
}

#pragma mark ObjectiveResource overrides to handle nestd resources


@end
