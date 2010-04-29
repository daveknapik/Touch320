//
//  RecipeBookDataSource.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>
#import "RecipeBookModel.h"

@interface RecipeBookDataSource : TTListDataSource {
	RecipeBookModel* _recipeBookModel;
}

- (id)initWithModel:(NSString *)category;

@end

