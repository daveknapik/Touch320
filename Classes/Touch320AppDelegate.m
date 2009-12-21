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

#import "ImageGalleryViewController.h"

#import "CatalogSamplerViewController.h"
#import "RadioViewController.h"
#import "Three20/Three20.h"

@implementation Touch320AppDelegate

@synthesize window;
@synthesize tabBarController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	// Allow HTTP response size to be unlimited.
    [[TTURLRequestQueue mainQueue] setMaxContentLength:0];
    
    // Configure the in-memory image cache to keep approximately
    // 10 images in memory, assuming that each picture's dimensions
    // are 320x480. Note that your images can have whatever dimensions
    // you want, I am just setting this to a reasonable value
    // since the default is unlimited.
    [[TTURLCache sharedCache] setMaxPixelCount:10*320*480];
	
	//set up the tabBarController and a local array of controllers
    tabBarController = [[MainTabBarController alloc] init];
	NSMutableArray *localControllersArray = [[NSMutableArray alloc] initWithCapacity:4];
	UINavigationController *localNavigationController;
	
	//set up the NewsViewController
	NewsViewController *newsViewController;
	newsViewController = [[NewsViewController alloc] initWithTabBar];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[newsViewController release];
	
	// setup the ImageGalleryViewController
	ImageGalleryViewController *imageGalleryViewController;
	imageGalleryViewController = [[ImageGalleryViewController alloc] initWithTabBar];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:imageGalleryViewController];
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[imageGalleryViewController release];
	
	// setup the CatalogSamplerViewController
	CatalogSamplerViewController *catalogSamplerViewController;
	catalogSamplerViewController = [[CatalogSamplerViewController alloc] initWithTabBar];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:catalogSamplerViewController];
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[catalogSamplerViewController release];
	
	// setup the RadioViewController
	RadioViewController *radioViewController;
	radioViewController = [[RadioViewController alloc] initWithTabBar];
	localNavigationController = [[UINavigationController alloc] initWithRootViewController:radioViewController];
	[localControllersArray addObject:localNavigationController];
	[localNavigationController release];
	[radioViewController release];
	
	// load up our tab bar controller with the view controllers
	tabBarController.viewControllers = localControllersArray;
	
	// release the array because the tab bar controller now has it
	[localControllersArray release];
	
    /* [tabBarController setViewControllers:
     [NSArray arrayWithObjects:
      [[[UINavigationController alloc] initWithRootViewController:[[[NewsViewController alloc] init] autorelease]] autorelease],
      [[[UINavigationController alloc] initWithRootViewController:[[[ImageGalleryViewController alloc] init] autorelease]] autorelease],
      nil]]; */
	
    // Override point for customization after application launch
	[window addSubview:tabBarController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}

@end
