//
//  NewsViewController.h
//  Touch
//
//  Created by Dave Knapik on 10/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface NewsViewController : UITableViewController {
	NSMutableArray *newsItems;
}

@property (nonatomic, retain) NSMutableArray *newsItems;

-(id)initWithTabBar;

@end
