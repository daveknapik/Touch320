//
//  CatalogItemViewController.m
//  Touch320
//
//  Created by Dave Knapik on 24/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CatalogItemViewController.h"
#import "Touch320AppDelegate.h"

@implementation CatalogItemViewController

@synthesize artist = _artist,
description = _description,
subtitle = _subtitle,
duration = _duration,
mp3_sample_url = _mp3_sample_url,
catalogItemView = _catalogItemView,
titleLabel = _titleLabel,
artistLabel = _artistLabel,
descriptionLabel = _descriptionLabel,
subtitleLabel = _subtitleLabel,
durationLabel = _durationLabel,
titleValue = _titleValue,
artistValue = _artistValue,
descriptionValue = _descriptionValue,
subtitleValue = _subtitleValue,
durationValue = _durationValue;

- (id)initWithCatalogItem:(NSString *)placeholder query:(NSDictionary*)query
{
	if (self = [self init]) {		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title = [query objectForKey:@"title"];
		
		self.navigationBarStyle = UIBarStyleDefault; 
		self.navigationBarTintColor	= [UIColor blackColor];
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.artist = [query objectForKey:@"artist"];
		self.subtitle = [query objectForKey:@"subtitle"];
		self.description = [query objectForKey:@"description"];
		self.duration = [query objectForKey:@"duration"];
		self.mp3_sample_url = [query objectForKey:@"mp3_sample_url"];
		
		NSLog(@"mp3 sample url: %@",self.mp3_sample_url);
		
		if ([self.mp3_sample_url length] == 0) {
			NSLog(@"mp3 sample url is null");
		}
		else {
			NSLog(@"mp3 sample url length: %d", [self.mp3_sample_url length]);
		}
		
		Touch320AppDelegate *appDelegate;
		appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
		
		appDelegate.link = self.mp3_sample_url;
		appDelegate.activeViewController = self;
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)viewDidLoad {
	self.view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 2300)];
	[self.view setContentSize:CGSizeMake(320,2300)];
	
	self.catalogItemView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 2300)];
	self.catalogItemView.backgroundColor = [UIColor whiteColor];
	
	[self.catalogItemView setContentSize:CGSizeMake(320, 2300)];
	
	[self.view addSubview:self.catalogItemView];
	
	//subtitle value
	UILabel *subtitleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 300, 20)];
	subtitleValue.text = self.subtitle;
	subtitleValue.textAlignment = UITextAlignmentLeft;
	subtitleValue.textColor = [UIColor blackColor];
	subtitleValue.font = [UIFont boldSystemFontOfSize:12];
	subtitleValue.backgroundColor = [UIColor whiteColor];
	subtitleValue.lineBreakMode = UILineBreakModeWordWrap;
	subtitleValue.adjustsFontSizeToFitWidth = YES;
	subtitleValue.numberOfLines = 0;
	
	subtitleValue.frame = [self resizeLabelFrame:subtitleValue
										 forText:self.subtitle];
	
	[self.view addSubview:subtitleValue];
	[subtitleValue release];
	
	//title value
	UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, subtitleValue.frame.size.height + 5, 300, 40)];
	titleValue.text = self.navigationItem.title;
	titleValue.textAlignment = UITextAlignmentLeft;
	titleValue.textColor = [UIColor blackColor];
	titleValue.font = [UIFont systemFontOfSize:12];
	titleValue.backgroundColor = [UIColor whiteColor];
	titleValue.lineBreakMode = UILineBreakModeWordWrap;
	titleValue.numberOfLines = 0;
	
	titleValue.frame = [self resizeLabelFrame:titleValue 
									  forText:self.navigationItem.title];
	
	[self.view addSubview:titleValue];
	[titleValue release];
	
	//description value
	UILabel *descriptionValue = [[UILabel alloc] initWithFrame:CGRectMake(5, subtitleValue.frame.size.height + titleValue.frame.size.height + 10, 300, 100)];
	descriptionValue.text = self.description;
	descriptionValue.textAlignment = UITextAlignmentLeft;
	descriptionValue.textColor = [UIColor blackColor];
	descriptionValue.font = [UIFont systemFontOfSize:12];
	descriptionValue.backgroundColor = [UIColor whiteColor];
	descriptionValue.lineBreakMode = UILineBreakModeWordWrap;
	descriptionValue.numberOfLines = 0;
	
	descriptionValue.frame = [self resizeLabelFrame:descriptionValue 
										forText:self.description];
	
	[self.view addSubview:descriptionValue];
	[descriptionValue release];
	
	if ([self.mp3_sample_url length] != 0) {
	
	//button background images
	UIImage* blackBackgroundImage = [[UIImage imageNamed:@"blackbutton.png"] stretchableImageWithLeftCapWidth:12.0f topCapHeight:0.0f];
	
	//play button
	playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	playButton.frame = CGRectMake(50, subtitleValue.frame.size.height + titleValue.frame.size.height + descriptionValue.frame.size.height + 15, 200, 40);
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[playButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	playButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	playButton.backgroundColor = [UIColor clearColor];
	playButton.alpha = 1;
	[playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:playButton];
	
	//pause button
	pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	pauseButton.frame = CGRectMake(50, subtitleValue.frame.size.height + titleValue.frame.size.height + descriptionValue.frame.size.height + 15, 200, 40);
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	[pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[pauseButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	pauseButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	pauseButton.backgroundColor = [UIColor clearColor];
	pauseButton.alpha = 0;
	[pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:pauseButton];
	
	//activityIndicatorView
	activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicatorView.center = CGPointMake(150, subtitleValue.frame.size.height + titleValue.frame.size.height + descriptionValue.frame.size.height + 40);
	[self.view addSubview:activityIndicatorView];
	
	[self load];
	
	}
	
    [super viewDidLoad];
}

- (CGRect)resizeLabelFrame:(UILabel*)label forText:(NSString*)text {
	//Calculate the expected size based on the font and linebreak mode of your label
	CGSize maximumSize = CGSizeMake(300,9999);
	
	CGSize expectedSize = [text sizeWithFont:label.font 
						   constrainedToSize:maximumSize 
							   lineBreakMode:label.lineBreakMode]; 
	
	//adjust the label the the new height.
	CGRect newFrame = label.frame;
	newFrame.size.height = expectedSize.height;
	label.frame = newFrame;
	
	return label.frame;
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.artist = nil;
	self.description = nil;
	self.duration = nil;
	self.mp3_sample_url = nil;
	
	self.catalogItemView = nil;
	
	self.titleLabel = nil;
	self.artistLabel = nil;
	self.subtitleLabel = nil;
	self.descriptionLabel = nil;
	self.durationLabel = nil;
	
	self.titleValue = nil;
	self.artistValue = nil;
	self.subtitleValue = nil;
	self.descriptionValue = nil;
	self.durationValue = nil;
	
	playButton = nil;
	pauseButton = nil;
	activityIndicatorView = nil;
	
	[super viewDidUnload];
}


- (void)dealloc {
	TT_RELEASE_SAFELY(_artist);
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_description);
	TT_RELEASE_SAFELY(_duration);
	TT_RELEASE_SAFELY(_mp3_sample_url);
	
	TT_RELEASE_SAFELY(_catalogItemView);
	
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_artistLabel);
	TT_RELEASE_SAFELY(_subtitleLabel);
	TT_RELEASE_SAFELY(_descriptionLabel);
	TT_RELEASE_SAFELY(_durationLabel);
	
	TT_RELEASE_SAFELY(_titleValue);
	TT_RELEASE_SAFELY(_artistValue);
	TT_RELEASE_SAFELY(_subtitleValue);
	TT_RELEASE_SAFELY(_descriptionValue);
	TT_RELEASE_SAFELY(_durationValue);
	
	TT_RELEASE_SAFELY(playButton);
	TT_RELEASE_SAFELY(pauseButton);
	TT_RELEASE_SAFELY(activityIndicatorView);
	
	[super dealloc];
}

- (void)showStopped {
	NSLog(@"showing stopped");
	[UIView beginAnimations:nil context:nil];
	[activityIndicatorView stopAnimating];
	pauseButton.alpha = 0;
	playButton.alpha = 0;
	[UIView commitAnimations];
}

- (void)showLoading {
	[UIView beginAnimations:nil context:nil];
	[activityIndicatorView startAnimating];
	pauseButton.alpha = 0;
	playButton.alpha = 0;
	[UIView commitAnimations];
}

- (void)showPlaying {
	if ([activityIndicatorView isAnimating]) {
		[self pause];
	}
	else {
		[UIView beginAnimations:nil context:nil];
		[activityIndicatorView stopAnimating];
		pauseButton.alpha = 1;
		playButton.alpha = 0;
		[UIView commitAnimations];
	}
}

- (void)showPaused {
	[UIView beginAnimations:nil context:nil];
	[activityIndicatorView stopAnimating];
	pauseButton.alpha = 0;
	playButton.alpha = 1;
	[UIView commitAnimations];
}

- (void)load {
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	AudioSessionSetActive(YES);
	
	NSLog(@"active audio player: %@",[appDelegate activeAudioPlayer]);
	
	[[appDelegate activeAudioPlayer] cancel];
	[[appDelegate activeAudioPlayer] release];
	
	audioPlayer = [[AudioPlayer alloc] initPlayerWithURL:[NSURL URLWithString:self.mp3_sample_url] delegate:self];
	//audioPlayer = [[AudioPlayer alloc] initPlayerWithURL:[NSURL URLWithString:@"http://www.daveknapik.com/audio/Silicon_Teens-Just_Like_Eddie.mp3"] delegate:self];
	
	appDelegate.activeAudioPlayer = audioPlayer;
	
	NSLog(@"active audio player: %@",[appDelegate activeAudioPlayer]);
	
	[self showLoading];
}

- (void)pause {
	audioPlayer.paused = YES;
	[self showPaused];
}

- (void)play {
	audioPlayer.paused = NO;
	[self showPlaying];
}

- (void)audioPlayerDownloadFailed:(AudioPlayer *)audioPlayer {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Audio download failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
	[self showStopped];
}

- (void)audioPlayerPlaybackStarted:(AudioPlayer *)audioPlayer {
	NSLog(@"CatalogItemViewController thinks playback has started");
	[self showPlaying];
}

- (void)audioPlayerPlaybackFinished:(AudioPlayer *)audioPlayer {
	NSLog(@"CatalogItemViewController thinks playback has completed");
	AudioSessionSetActive(NO);
	[self showStopped];
}


@end

