//
//  NewsItemViewController.h
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20+Additions.h>

@interface NewsItemViewController : TTViewController <UIWebViewDelegate> {
	NSString* _newsItemTitle;
	NSString* _newsItemLink;
	NSString* _pubDate;
	NSString* _description;
	UIActivityIndicatorView* _myIndicator;
	UILabel* _loadingText;
	UIWebView* _webView;
}

@property (nonatomic, copy) NSString* newsItemTitle;
@property (nonatomic, copy) NSString* newsItemLink;
@property (nonatomic, copy) NSString* pubDate;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, retain) UIActivityIndicatorView* myIndicator;
@property (nonatomic, retain) UILabel* loadingText;
@property (nonatomic, retain) UIWebView* webView;

- (id)initWithNavigatorURL:(NSString *)placeholder query:(NSDictionary*)query;

@end
