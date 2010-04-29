//
//  CatalogSamplerModel.h
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>

@interface CatalogSamplerModel : TTURLRequestModel {
	NSMutableDictionary* _catalogItems;
	NSUInteger page;
}

@property (nonatomic, retain) NSMutableDictionary* catalogItems;

@end
