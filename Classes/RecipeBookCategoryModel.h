//
//  RecipeBookCategoryModel.h
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>

@interface RecipeBookCategoryModel : TTURLRequestModel {
	NSMutableDictionary* _recipes;
	NSUInteger page;
}

@property (nonatomic, readonly) NSMutableDictionary*  recipes;

@end