//
//  CatalogSamplerDataSource.h
//  Touch320
//
//  Created by Dave Knapik on 26/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "CatalogSamplerModel.h"


@interface CatalogSamplerDataSource : TTListDataSource {
//	NSMutableArray* _catalogItems;
	CatalogSamplerModel* _catalogSamplerModel;
}

//@property (nonatomic, retain) NSMutableArray catalogItems;

- (id)initWithModel;

@end
