//
//  RadioItemViewController.h
//  Touch320
//
//  Created by Dave Knapik on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>
#import "AudioPlayer.h"

@interface RadioItemViewController : TTViewController <AudioPlayerDelegate> {
	NSString* _author;
	NSString* _subtitle;
	NSString* _summary;
	NSString* _pubDate;
	NSString* _link;
	NSString* _episode_duration;
	
	UIScrollView* _radioItemView;
	
	UILabel* _titleLabel;
	UILabel* _authorLabel;
	UILabel* _summaryLabel;
	UILabel* _subtitleLabel;
	UILabel* _pubDateLabel;
	UILabel* _episode_durationLabel;
	
	UILabel* _titleValue;
	UILabel* _authorValue;
	UILabel* _summaryValue;
	UILabel* _subtitleValue;
	UILabel* _pubDateValue;
	UILabel* _episode_durationValue;
	
	UIActivityIndicatorView* activityIndicatorView;
	UIButton* pauseButton;
	UIButton* playButton;
	
	AudioPlayer *audioPlayer;
}

@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* summary;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* pubDate;
@property (nonatomic, copy) NSString* link;
@property (nonatomic, copy) NSString* episode_duration;

@property (nonatomic, retain) UIScrollView* radioItemView;

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UILabel* authorLabel;
@property (nonatomic, retain) UILabel* summaryLabel;
@property (nonatomic, retain) UILabel* subtitleLabel;
@property (nonatomic, retain) UILabel* pubDateLabel;
@property (nonatomic, retain) UILabel* episode_durationLabel;

@property (nonatomic, retain) UILabel* titleValue;
@property (nonatomic, retain) UILabel* authorValue;
@property (nonatomic, retain) UILabel* summaryValue;
@property (nonatomic, retain) UILabel* subtitleValue;
@property (nonatomic, retain) UILabel* pubDateValue;
@property (nonatomic, retain) UILabel* episode_durationValue;

- (id)initWithRadioItem:(NSString *)placeholder query:(NSDictionary*)query;
- (CGRect)resizeLabelFrame:(UILabel*)label forText:(NSString*)text;

- (void)load;
- (void)pause;
- (void)play;
- (void)showPlaying;
- (void)showPaused;
- (void)showLoading;
- (void)showStopped;

@end
