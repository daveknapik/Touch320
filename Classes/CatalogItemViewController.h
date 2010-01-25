//
//  CatalogItemViewController.h
//  Touch320
//
//  Created by Dave Knapik on 24/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "AudioPlayer.h"

@interface CatalogItemViewController : TTViewController <AudioPlayerDelegate> {
	NSString* _artist;
	NSString* _subtitle;
	NSString* _description;
	NSString* _duration;
	NSString* _mp3_sample_url;
	
	UIScrollView* _catalogItemView;
	
	UILabel* _titleLabel;
	UILabel* _artistLabel;
	UILabel* _descriptionLabel;
	UILabel* _subtitleLabel;
	UILabel* _durationLabel;
	
	UILabel* _titleValue;
	UILabel* _artistValue;
	UILabel* _descriptionValue;
	UILabel* _subtitleValue;
	UILabel* _durationValue;
	
	UIActivityIndicatorView* activityIndicatorView;
	UIButton* pauseButton;
	UIButton* playButton;
	
	AudioPlayer *audioPlayer;
}

@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* duration;
@property (nonatomic, copy) NSString* mp3_sample_url;

@property (nonatomic, retain) UIScrollView* catalogItemView;

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UILabel* artistLabel;
@property (nonatomic, retain) UILabel* descriptionLabel;
@property (nonatomic, retain) UILabel* subtitleLabel;
@property (nonatomic, retain) UILabel* durationLabel;

@property (nonatomic, retain) UILabel* titleValue;
@property (nonatomic, retain) UILabel* artistValue;
@property (nonatomic, retain) UILabel* descriptionValue;
@property (nonatomic, retain) UILabel* subtitleValue;
@property (nonatomic, retain) UILabel* durationValue;

- (id)initWithCatalogItem:(NSString *)placeholder query:(NSDictionary*)query;
- (CGRect)resizeLabelFrame:(UILabel*)label forText:(NSString*)text;

- (void)load;
- (void)pause;
- (void)play;
- (void)showPlaying;
- (void)showPaused;
- (void)showLoading;
- (void)showStopped;

@end