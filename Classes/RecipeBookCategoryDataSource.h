//
//  RecipeBookCategoryDataSource.h
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>
#import "RecipeBookCategoryModel.h"

@interface RecipeBookCategoryDataSource : TTListDataSource {
	RecipeBookCategoryModel* _recipeBookCategoryModel;
}

- (id)initWithModel;

@end
