//
//  Touch320AppDelegate.h
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageGalleryPhotoSource.h"

@interface Touch320AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	UITabBarController *tabBarController;
	ImageGalleryPhotoSource *photoSource;
}

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) UIWindow *window;

@end

