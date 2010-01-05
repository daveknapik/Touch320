//
//  RecipeBookTableItem.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface RecipeBookTableItem : TTTableTextItem {
	NSString* _title;
	NSString* _link;
}

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* link;

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			  link:(NSString*)link;

@end