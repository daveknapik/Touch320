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
release_description = _release_description,
subtitle = _subtitle,
release_duration = _release_duration,
mp3_sample_url = _mp3_sample_url,
cover_art_url = _cover_art_url,
catalogItemView = _catalogItemView,
titleLabel = _titleLabel,
artistLabel = _artistLabel,
descriptionLabel = _descriptionLabel,
subtitleLabel = _subtitleLabel,
release_durationLabel = _release_durationLabel,
titleValue = _titleValue,
artistValue = _artistValue,
descriptionValue = _descriptionValue,
subtitleValue = _subtitleValue,
release_durationValue = _release_durationValue,
cover_art = _cover_art;

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
		self.release_description = [query objectForKey:@"release_description"];
		self.release_duration = [query objectForKey:@"release_duration"];
		self.mp3_sample_url = [[query objectForKey:@"mp3_sample_url"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		//self.mp3_sample_url = @"http://www.daveknapik.com/audio/Silicon_Teens-Just_Like_Eddie.mp3";
		self.cover_art_url = [[query objectForKey:@"cover_art_url"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		
		NSLog(self.mp3_sample_url);
		
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
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	self.view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.deviceWidth, 2300)];
	[self.view setContentSize:CGSizeMake(appDelegate.deviceWidth,2300)];
	
	self.catalogItemView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.deviceWidth, 2300)];
	self.catalogItemView.backgroundColor = [UIColor whiteColor];
	
	[self.catalogItemView setContentSize:CGSizeMake(appDelegate.deviceWidth, 2300)];
	
	[self.view addSubview:self.catalogItemView];
	
	//initialize y-axis subview placement variable
	int yAxisPlacement = 0;
	int previousSubviewHeight = 0;
	
	//subtitle value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *subtitleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 20)];
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
	previousSubviewHeight = subtitleValue.frame.size.height;
	
	//title value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 40)];
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
	previousSubviewHeight = titleValue.frame.size.height;
	
	//image value
	
	//TODO: add check for validity of image at cover_art_url
	
	//if ([self.cover_art_url length] != 0) {
		yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
		TTPhotoView* cover_art = [[TTPhotoView alloc] initWithFrame:CGRectMake(5, yAxisPlacement, 150, 150)];
		[cover_art setDelegate:self];
		[cover_art showStatus:nil];
	cover_art.hidesExtras = YES;
	cover_art.hidesCaption = YES;
		cover_art.urlPath = self.cover_art_url;
		
		[self.view addSubview:cover_art];
		[cover_art release];
		previousSubviewHeight = cover_art.frame.size.height;
	//}
		
	//release_description value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *descriptionValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 100)];
	descriptionValue.text = self.release_description;
	descriptionValue.textAlignment = UITextAlignmentLeft;
	descriptionValue.textColor = [UIColor blackColor];
	descriptionValue.font = [UIFont systemFontOfSize:12];
	descriptionValue.backgroundColor = [UIColor whiteColor];
	descriptionValue.lineBreakMode = UILineBreakModeWordWrap;
	descriptionValue.numberOfLines = 0;
	
	descriptionValue.frame = [self resizeLabelFrame:descriptionValue 
										forText:self.release_description];
	
	[self.view addSubview:descriptionValue];
	[descriptionValue release];
	previousSubviewHeight = descriptionValue.frame.size.height;
	
	//BUTTONS
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	//button background images
	UIImage* blackBackgroundImage = [[UIImage imageNamed:@"blackbutton.png"] stretchableImageWithLeftCapWidth:12.0f topCapHeight:0.0f];
	
	//play button
	playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	playButton.frame = CGRectMake(50, yAxisPlacement, 200, 40);
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[playButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	playButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	playButton.backgroundColor = [UIColor clearColor];
	playButton.alpha = 1;
	[playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
	
	//pause button
	pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	pauseButton.frame = CGRectMake(50, yAxisPlacement, 200, 40);
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	[pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[pauseButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	pauseButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	pauseButton.backgroundColor = [UIColor clearColor];
	pauseButton.alpha = 0;
	[pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
	
	//activityIndicatorView
	activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicatorView.center = CGPointMake(150, yAxisPlacement + 35);
	
	//if ([self.mp3_sample_url length] != 0) {
		[self.view addSubview:playButton];
		[self.view addSubview:pauseButton];
		[self.view addSubview:activityIndicatorView];
		
		[self load];
	//}
	
    [super viewDidLoad];
}

- (CGRect)resizeLabelFrame:(UILabel*)label forText:(NSString*)text {
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	//Calculate the expected size based on the font and linebreak mode of your label
	CGSize maximumSize = CGSizeMake(appDelegate.deviceWidth - 20,9999);
	
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
	self.release_description = nil;
	self.release_duration = nil;
	self.mp3_sample_url = nil;
	self.cover_art_url = nil;
	
	self.catalogItemView = nil;
	
	self.titleLabel = nil;
	self.artistLabel = nil;
	self.subtitleLabel = nil;
	self.descriptionLabel = nil;
	self.release_durationLabel = nil;
	
	self.titleValue = nil;
	self.artistValue = nil;
	self.subtitleValue = nil;
	self.descriptionValue = nil;
	self.release_durationValue = nil;
	
	playButton = nil;
	pauseButton = nil;
	activityIndicatorView = nil;
	_cover_art = nil;
	
	[super viewDidUnload];
}


- (void)dealloc {
	TT_RELEASE_SAFELY(_artist);
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_release_description);
	TT_RELEASE_SAFELY(_release_duration);
	TT_RELEASE_SAFELY(_mp3_sample_url);
	TT_RELEASE_SAFELY(_cover_art_url);
	
	TT_RELEASE_SAFELY(_catalogItemView);
	
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_artistLabel);
	TT_RELEASE_SAFELY(_subtitleLabel);
	TT_RELEASE_SAFELY(_descriptionLabel);
	TT_RELEASE_SAFELY(_release_durationLabel);
	
	TT_RELEASE_SAFELY(_titleValue);
	TT_RELEASE_SAFELY(_artistValue);
	TT_RELEASE_SAFELY(_subtitleValue);
	TT_RELEASE_SAFELY(_descriptionValue);
	TT_RELEASE_SAFELY(_release_durationValue);
	
	TT_RELEASE_SAFELY(playButton);
	TT_RELEASE_SAFELY(pauseButton);
	TT_RELEASE_SAFELY(activityIndicatorView);
	TT_RELEASE_SAFELY(_cover_art);
	
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
	
	NSLog(@"step 1 - active audio player: %@",[appDelegate activeAudioPlayer]);
	
	[[appDelegate activeAudioPlayer] cancel];
	[[appDelegate activeAudioPlayer] release];
	
	audioPlayer = [[AudioPlayer alloc] initPlayerWithURL:[NSURL URLWithString:self.mp3_sample_url] delegate:self];
	
	appDelegate.activeAudioPlayer = audioPlayer;
	
	NSLog(@"step 2 - active audio player: %@",[appDelegate activeAudioPlayer]);
	
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

#pragma mark TTImageViewDelegate methods

- (void)imageViewDidStartLoad:(TTImageView *)imageView{
	NSLog(@"hi, I started loading the image");
}

- (void)imageView:(TTImageView *)imageView didLoadImage:(UIImage*)image{
	
	NSLog(@"hi, I finished loading the image");
	//[coverArtActivityIndicatorView stopAnimating];
} 	 

- (void)imageViewDidFailLoadWithError:(NSError*)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:@"Cover art failed to load"
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
}  	 

@end

