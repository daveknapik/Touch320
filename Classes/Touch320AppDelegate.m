//
//  Touch320AppDelegate.m
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "Touch320AppDelegate.h"
#import "MainTabBarController.h"
#import "NewsViewController.h"
#import "NewsItemViewController.h"
#import "ImageGalleryViewController.h"
#import "RecipeBookViewController.h"

#import "CatalogSamplerViewController.h"
#import "RadioViewController.h"
#import "RadioItemViewController.h"
#import "Three20/Three20.h"

@implementation Touch320AppDelegate

@synthesize link = _link, activeViewController = _activeViewController, activeAudioPlayer = _activeAudioPlayer;

void interruptionListener (void *inClientData, UInt32 inInterruptionState);

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	// Allow HTTP response size to be unlimited.
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    
    // Configure the in-memory image cache to keep approximately
    // 10 images in memory, assuming that each picture's dimensions
    // are 320x480. Note that your images can have whatever dimensions
    // you want, I am just setting this to a reasonable value
    // since the default is unlimited.
    [[TTURLCache sharedCache] setMaxPixelCount:10*320*480];
	
	TTNavigator* navigator = [TTNavigator navigator];
	navigator.persistenceMode = TTNavigatorPersistenceModeNone;
	navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
	
	TTURLMap* map = navigator.URLMap;
	
	// Any URL that doesn't match will fall back on this one, and open in the web browser
	[map from:@"*" toViewController:[TTWebController class]];
	
	[map from:@"tt://tabBar" toSharedViewController:[MainTabBarController class]];
	[map from:@"tt://news/(initWithTabBar:)" toSharedViewController:[NewsViewController class]];
	[map from:@"tt://newsItem/(initWithNavigatorURL:)" toViewController:[NewsItemViewController class]];
	[map from:@"tt://images/(initWithTabBar:)" toSharedViewController:[ImageGalleryViewController class]];
	[map from:@"tt://catalogSampler/(initWithTabBar:)" toSharedViewController:[CatalogSamplerViewController class]];
	[map from:@"tt://radio/(initWithTabBar:)" toSharedViewController:[RadioViewController class]];
	[map from:@"tt://radioItem/(initWithRadioItem:)" toViewController:[RadioItemViewController class]];
	[map from:@"tt://recipeBook/(initWithTabBar:)" toSharedViewController:[RecipeBookViewController class]];
		
	NSLog(@"controllers created");
	
	// Before opening the tab bar, we see if the controller history was persisted the last time
	if (![navigator restoreViewControllers]) {
		//This is the first launch, so we just start with the tab bar
		[navigator openURL:@"tt://tabBar" animated:NO];
	}	
	
	AudioSessionInitialize (
							NULL,                  // use the default (main) run loop
							NULL,                  // use the default run loop mode
							interruptionListener,  // a reference to your interruption callback
							self                   // userData
							);
	
	UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
	AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
}

- (BOOL)navigator:(TTNavigator*)navigator shouldOpenURL:(NSURL*)URL {
	return YES;
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
	[[TTNavigator navigator] openURL:URL.absoluteString animated:NO];
	return YES;
}

- (void)dealloc {
	[super dealloc];
}

- (void)bollocks {
	NSLog(@"I am the AppDelegate and I think the Active View Controller is: %@ %@", self.activeViewController,self.link);
}

void interruptionListener(void *userData, UInt32  interruptionState) {
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	if (interruptionState == kAudioSessionBeginInterruption) {
		[appDelegate.activeViewController pause];
		AudioSessionSetActive(NO);
	} else if (interruptionState == kAudioSessionEndInterruption) {
		AudioSessionSetActive(YES);
		[appDelegate.activeViewController play];
	}
}

@end
