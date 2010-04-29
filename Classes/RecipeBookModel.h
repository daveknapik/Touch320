//
//  RecipeBookModel.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>

@interface RecipeBookModel : TTURLRequestModel {
	NSMutableDictionary* _recipes;
	NSString* _feedURL;
	NSUInteger page;
}

@property (nonatomic, readonly) NSMutableDictionary*  recipes;
@property (nonatomic, retain) NSString* feedURL;

- (id)initWithCategory:(NSString *)category;

@end