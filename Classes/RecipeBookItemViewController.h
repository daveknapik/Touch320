//
//  RecipeBookItemViewController.h
//  Touch320
//
//  Created by Dave Knapik on 14/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>
#import <MessageUI/MessageUI.h>
#import "AudioPlayer.h"

@interface RecipeBookItemViewController : TTViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate> {
	NSString* _author;
	NSString* _recipe_title;
	NSString* _recipe_description;
	
	UILabel* _titleValue;
	UILabel* _authorValue;
	UILabel* _descriptionValue;
	
	UIWebView* _recipeItemView;
}

@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* recipe_title;
@property (nonatomic, copy) NSString* recipe_description;

@property (nonatomic, retain) UILabel* titleValue;
@property (nonatomic, retain) UILabel* authorValue;
@property (nonatomic, retain) UILabel* descriptionValue;

@property (nonatomic, retain) UIWebView* recipeItemView;

- (id)initWithRecipeItem:(NSString *)placeholder query:(NSDictionary*)query;
- (CGRect)resizeLabelFrame:(UILabel*)label forText:(NSString*)text;

@end
