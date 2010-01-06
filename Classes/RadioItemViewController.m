//
//  RadioItemViewController.m
//  Touch320
//
//  Created by Dave Knapik on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioItemViewController.h"


@implementation RadioItemViewController

@synthesize author = _author,
			summary = _summary,
			subtitle = _subtitle,
			pubDate = _pubDate,
			link = _link,
			duration = _duration;

- (id)initWithRadioItem:(NSString *)placeholder query:(NSDictionary*)query
{
	if (self = [self init]) {		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title = [query objectForKey:@"title"];
		
		self.navigationBarStyle = UIBarStyleDefault; 
		self.navigationBarTintColor	= [UIColor blackColor];
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.author = [query objectForKey:@"author"];
		self.subtitle = [query objectForKey:@"subtitle"];
		self.summary = [query objectForKey:@"summary"];
		self.pubDate = [query objectForKey:@"pubDate"];
		self.link = [query objectForKey:@"link"];
		self.duration = [query objectForKey:@"duration"];
		
		/*
		NSLog(@"radio item title: %@",self.navigationItem.title);
		NSLog(@"radio item subtitle: %@",self.subtitle);
		NSLog(@"radio item author: %@",self.author);
		NSLog(@"radio item summary: %@",self.summary);
		NSLog(@"radio item duration: %@",self.duration);
		NSLog(@"radio item link: %@",self.link);
		NSLog(@"radio item pubDate: %@",self.pubDate);
		*/
	}
	
	return self;
}

- (id)init {
	[super init];
	
	return self;
}

- (void)viewDidLoad {
		
    [super viewDidLoad];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.author = nil;
	self.summary = nil;
	self.pubDate = nil;
	self.link = nil;
	self.duration = nil;
	[super viewDidUnload];
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_author);
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_summary);
	TT_RELEASE_SAFELY(_pubDate);
	TT_RELEASE_SAFELY(_link);
	TT_RELEASE_SAFELY(_duration);
	[super dealloc];
}



@end
