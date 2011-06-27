//
//  Touch320AppDelegate.h
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20+Additions.h>

@interface Touch320AppDelegate : NSObject <UIApplicationDelegate> {
	NSString* _link;
	NSString* _numberOfThumbnails;
	NSString* _imageSize;
	CGFloat _deviceWidth;
	CGFloat _deviceHeight;
	CGFloat _deviceMultiplier;
	UIViewController* _activeViewController;
}

@property (nonatomic, retain) NSString* link;
@property (nonatomic, retain) NSString* numberOfThumbnails;
@property (nonatomic, retain) NSString* imageSize;
@property CGFloat deviceWidth;
@property CGFloat deviceHeight;
@property CGFloat deviceMultiplier;
@property (nonatomic, retain) UIViewController* activeViewController;

- (void)bollocks;

@end

