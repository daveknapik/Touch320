//
//  NewsTableItem.h
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>

@interface NewsTableItem : TTTableTextItem {
	NSString* _title;
	NSString* _link;
}

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* link;

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			  link:(NSString*)link;

@end
