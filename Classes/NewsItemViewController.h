//
//  NewsItemViewController.h
//  Touch
//
//  Created by Dave Knapik on 13/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>

@interface NewsItemViewController : TTViewController <UIWebViewDelegate> {
	NSString* _newsItemLink;
	UIActivityIndicatorView* _myIndicator;
	UILabel* _loadingText;
	UIWebView* _webView;
}

@property (nonatomic, copy) NSString* newsItemLink;
@property (nonatomic, retain) UIActivityIndicatorView* myIndicator;
@property (nonatomic, retain) UILabel* loadingText;
@property (nonatomic, retain) UIWebView* webView;

- (id)initWithNavigatorURL:(NSString *)placeholder query:(NSDictionary*)query;

@end
