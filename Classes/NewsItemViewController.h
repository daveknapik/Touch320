//
//  NewsItemViewController.h
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsItemViewController : UIViewController {
	NewsItem *newsItem;
}

@property (nonatomic, retain) NewsItem *newsItem;

@end
