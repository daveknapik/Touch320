//
//  NewsItemViewController.m
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsItemViewController.h"
#import "NewsItem.h"
#import "Book.h"
#import "CatalogSamplerDataSource.h"
#import "Touch320AppDelegate.h"

@implementation NewsItemViewController

@synthesize newsItemLink = _newsItemLink, 
			pubDate = _pubDate,
			description = _description,
			myIndicator = _myIndicator,
			loadingText = _loadingText,
			webView = _webView;

- (id)initWithNavigatorURL:(NSString *)placeholder query:(NSDictionary*)query
{
	if (self = [self init]) {		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title = [query objectForKey:@"title"];
		
		self.navigationBarStyle = UIBarStyleDefault; 
		self.navigationBarTintColor	= [UIColor blackColor];
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.newsItemLink = [query objectForKey:@"link"];
		self.pubDate = [query objectForKey:@"pubDate"];
		self.description = [query objectForKey:@"description"];
		
		self.loadingText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
		self.loadingText.text = @"Loading...";
		self.loadingText.textColor = [UIColor grayColor];
		self.loadingText.textAlignment = UITextAlignmentCenter;
		self.loadingText.center = CGPointMake(160, 165);
		
		self.myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		self.myIndicator.center = CGPointMake(160, 195);
		self.myIndicator.hidesWhenStopped = YES;
		
		//NSURL *url = [NSURL URLWithString:self.newsItemLink];
		//NSURLRequest *request = [NSURLRequest requestWithURL:url];
		//[self openRequest:request];
	}
	
	return self;
}

- (id)init {
	[super init];
	
	return self;
}

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
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.deviceWidth, appDelegate.deviceHeight - 114)];
	self.webView.delegate = self;
	
	NSString *newsHTML = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\"width=device-width\" />"];
	
	newsHTML = [newsHTML stringByAppendingString:@"<link rel=\"stylesheet\" media=\"only screen and (max-device-width: 480px)\" href=\"http://www.daveknapik.com/dropbox/mobile.css\" />"];
	newsHTML = [newsHTML stringByAppendingString:@"<link rel=\"stylesheet\" media=\"only screen and (min-device-width: 481px) and (max-device-width: 1024px)\" href=\"http://www.daveknapik.com/dropbox/ipad.css\" />"];
	
	newsHTML = [newsHTML stringByAppendingString:@"<p id='title'><strong>"];
	newsHTML = [newsHTML stringByAppendingString:self.navigationItem.title];
	newsHTML = [newsHTML stringByAppendingString:@"</strong>"];
	
	newsHTML = [newsHTML stringByAppendingString:@"<br />"];
	//newsHTML = [newsHTML stringByAppendingString:self.pubDate];
	newsHTML = [newsHTML stringByAppendingString:@"</p>"];
	
	newsHTML = [newsHTML stringByAppendingString:@"<span class='bodycopy'>"];
	newsHTML = [newsHTML stringByAppendingString:self.description];
	newsHTML = [newsHTML stringByAppendingString:@"</span>"];
	
	[self.webView loadHTMLString:newsHTML baseURL:nil];
	
	self.webView.scalesPageToFit = YES;
	self.webView.autoresizesSubviews = YES;
	
	[self.view addSubview:self.webView];
	
    [super viewDidLoad];
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
} */ 
 
/*- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	if (fromInterfaceOrientation == UIInterfaceOrientationPortrait) {
		self.webView.frame = CGRectMake(0,0,366,320);
	}
	else {
		self.webView.frame = CGRectMake(0,0,320,366);
	}
}*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.myIndicator = nil;
	self.newsItemLink = nil;
	self.pubDate = nil;
	self.description = nil;
	self.loadingText = nil;
	self.webView = nil;
	[super viewDidUnload];
}


- (void)dealloc {
	TT_RELEASE_SAFELY(_myIndicator); 
	TT_RELEASE_SAFELY(_newsItemLink);
	TT_RELEASE_SAFELY(_pubDate);
	TT_RELEASE_SAFELY(_description);
	TT_RELEASE_SAFELY(_loadingText);
	TT_RELEASE_SAFELY(_webView);
    [super dealloc];
}

#pragma mark UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView*)webView {
	NSLog(@"loading");
	
	[self.myIndicator startAnimating];
	[self.view addSubview:self.loadingText];
	[self.view addSubview:self.myIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSLog(@"finished loading");
	[self.loadingText removeFromSuperview];
	[self.myIndicator stopAnimating];
}


@end
