//
//  MainTabBarController.m
//  Touch320
//
//  Created by Dave Knapik on 21/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarController.h"

@implementation MainTabBarController

- (void)viewDidLoad {
	[self setTabURLs:[NSArray arrayWithObjects:
					  @"tt://news/1",
					  @"tt://images/1",
					  @"tt://catalogSampler/1",
					  @"tt://radio/1",
					  @"tt://recipeBook/1",
					  nil]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
} 

@end
