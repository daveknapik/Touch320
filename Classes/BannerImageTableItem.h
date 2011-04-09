//
//  BannerImageTableItem.h
//  Touch320
//
//  Created by David Knapik on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>

@interface BannerImageTableItem : TTTableTextItem {
	UIImage* _banner;
}

@property(nonatomic,retain) UIImage* banner;

+ (id)itemWithBannerImage:(UIImage*)banner;


@end