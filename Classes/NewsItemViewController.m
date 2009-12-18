//
//  NewsItemViewController.m
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsItemViewController.h"
#import "NewsItem.h"

@implementation NewsItemViewController

@synthesize newsItem;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (void)viewDidLoad {
	UIWebView *webView;
	webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	NSString *html = [NSString stringWithFormat:@"<p><a href='%@'>%@</a></p>%@", newsItem.link, newsItem.title, newsItem.description];
	[webView loadHTMLString:html baseURL:nil];
	webView.hidden = NO;
	webView.scalesPageToFit = YES;
	
	[self.view addSubview:webView];
	[webView release];
    [super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[newsItem release];
    [super dealloc];
}


@end
