//
//  NewsDataSource.h
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "NewsModel.h"

@interface NewsDataSource : TTListDataSource {
	NewsModel* _newsModel;
}

- (id)initWithModel;

@end
