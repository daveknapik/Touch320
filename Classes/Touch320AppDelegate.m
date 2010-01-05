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
#import "Three20/Three20.h"

@implementation Touch320AppDelegate

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
	[map from:@"tt://recipeBook/(initWithTabBar:)" toSharedViewController:[RecipeBookViewController class]];
		
	NSLog(@"controllers created");
	
	// Before opening the tab bar, we see if the controller history was persisted the last time
	if (![navigator restoreViewControllers]) {
		//This is the first launch, so we just start with the tab bar
		[navigator openURL:@"tt://tabBar" animated:NO];
	}	
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

@end
