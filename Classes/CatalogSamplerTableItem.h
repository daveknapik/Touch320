//
//  CatalogSamplerTableItem.h
//  Touch320
//
//  Created by Dave Knapik on 15/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>


@interface CatalogSamplerTableItem : TTTableSubtitleItem {
	NSString* _title;
	NSString* _thoughts;
}

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* thoughts;

+ (id)itemWithText:(NSString*)text 
			 title:(NSString*)title 
			thoughts:(NSString*)thoughts;

@end

