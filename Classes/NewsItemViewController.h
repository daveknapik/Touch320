//
//  NewsItemViewController.h
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface NewsItemViewController : TTViewController {
	NSString* _newsItemLink;
}

@property (nonatomic, copy) NSString* newsItemLink;

- (id)initWithNavigatorURL:(NSString *)placeholder query:(NSDictionary*)query;

@end
