//
//  RadioTableItem.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface RadioTableItem : TTTableSubtitleItem {
	NSString* _title;
	NSString* _author;
}

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* author;

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			author:(NSString*)author 
		  subtitle:(NSString*)subtitle;

@end
