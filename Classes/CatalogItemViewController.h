//
//  CatalogItemViewController.h
//  Touch320
//
//  Created by Dave Knapik on 24/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20+Additions.h>
#import "AudioPlayer.h"

@interface CatalogItemViewController : TTViewController <AudioPlayerDelegate, TTImageViewDelegate, UIAlertViewDelegate> {
	NSString* _release_title;
	NSString* _artist;
	NSString* _subtitle;
	NSString* _release_description;
	NSString* _release_duration;
	NSString* _mp3_sample_url;
	NSString* _cover_art_url;
	NSString* _itunes_url;
	
	UIScrollView* _catalogItemView;
	
	UILabel* _titleLabel;
	UILabel* _artistLabel;
	UILabel* _descriptionLabel;
	UILabel* _subtitleLabel;
	UILabel* _release_durationLabel;
	
	UILabel* _titleValue;
	UILabel* _artistValue;
	UILabel* _descriptionValue;
	UILabel* _subtitleValue;
	UILabel* _release_durationValue;
	
	TTPhotoView* _cover_art;
	
	UIActivityIndicatorView* activityIndicatorView;
	UIButton* pauseButton;
	UIButton* playButton;
	UIButton* buyButton;
	
	AudioPlayer *audioPlayer;
}

@property (nonatomic, copy) NSString* release_title;
@property (nonatomic, copy) NSString* artist;
@property (nonatomic, copy) NSString* release_description;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* release_duration;
@property (nonatomic, copy) NSString* mp3_sample_url;
@property (nonatomic, copy) NSString* cover_art_url;
@property (nonatomic, copy) NSString* itunes_url;

@property (nonatomic, retain) UIScrollView* catalogItemView;

@property (nonatomic, retain) UILabel* titleLabel;
@property (nonatomic, retain) UILabel* artistLabel;
@property (nonatomic, retain) UILabel* descriptionLabel;
@property (nonatomic, retain) UILabel* subtitleLabel;
@property (nonatomic, retain) UILabel* release_durationLabel;

@property (nonatomic, retain) UILabel* titleValue;
@property (nonatomic, retain) UILabel* artistValue;
@property (nonatomic, retain) UILabel* descriptionValue;
@property (nonatomic, retain) UILabel* subtitleValue;
@property (nonatomic, retain) UILabel* release_durationValue;

@property (nonatomic, retain) TTPhotoView* cover_art;

- (id)initWithCatalogItem:(NSString *)placeholder query:(NSDictionary*)query;
- (CGRect)resizeLabelFrame:(UILabel*)label forText:(NSString*)text;

- (void)load;
- (void)pause;
- (void)play;
- (void)buttonClicked;
- (void)showPlaying;
- (void)showPaused;
- (void)showLoading;
- (void)showStopped;

@end
