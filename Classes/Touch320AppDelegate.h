//
//  Touch320AppDelegate.h
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20+Additions.h>
#import "AudioPlayer.h"

@interface Touch320AppDelegate : NSObject <UIApplicationDelegate> {
	NSString* _link;
	CGFloat _deviceWidth;
	UIViewController* _activeViewController;
	AudioPlayer* _activeAudioPlayer;
}

@property (nonatomic, retain) NSString* link;
@property CGFloat deviceWidth;
@property (nonatomic, retain) UIViewController* activeViewController;
@property (nonatomic, retain) AudioPlayer* activeAudioPlayer;

- (void)bollocks;

@end

