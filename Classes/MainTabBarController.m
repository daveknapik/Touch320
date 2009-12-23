//
//  MainTabBarController.m
//  Touch320
//
//  Created by Dave Knapik on 21/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "MainTabBarController.h"


@implementation MainTabBarController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:interfaceOrientation];
} 

@end
