//
//  BannerImageTableItem.m
//  Touch320
//
//  Created by David Knapik on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BannerImageTableItem.h"


@implementation BannerImageTableItem

@synthesize banner= _banner; 

///////////////////////////////////////////////////////////////////////////////////////////////////

+ (id)itemWithBannerImage:(UIImage*)banner { 
	BannerImageTableItem* item = [[[self alloc] init] autorelease]; 
	
	item.banner = banner; 
	
	return item; 
} 

- (id)init { 
	if (self = [super init]) { 
		_banner = nil; 
	} 
	
	return self;
} 

- (void)dealloc { 
	TT_RELEASE_SAFELY(_banner); 
	[super dealloc];
}

- (id)initWithCoder:(NSCoder*)decoder { 
	if (self = [super initWithCoder:decoder]) { 
		self.banner = [decoder decodeObjectForKey:@"banner"]; 
	} 
	
	return self;
} 

- (void)encodeWithCoder:(NSCoder*)encoder { 
	[super encodeWithCoder:encoder]; 
	
	if (self.banner) { 
		[encoder encodeObject:self.banner forKey:@"banner"]; 
	} 
} 


@end
