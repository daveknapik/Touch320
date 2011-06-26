//
//  RadioItemViewController.m
//  Touch320
//
//  Created by Dave Knapik on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioItemViewController.h"
#import "Touch320AppDelegate.h"
#import "TJMAudioCenter.h"


@implementation RadioItemViewController

@synthesize author = _author,
			summary = _summary,
			subtitle = _subtitle,
			pubDate = _pubDate,
			link = _link,
			episode_duration = _episode_duration,
			title_label = _title_label,
			subtitle_label = _subtitle_label,
			radioItemView = _radioItemView,
			titleLabel = _titleLabel,
			authorLabel = _authorLabel,
			summaryLabel = _summaryLabel,
			subtitleLabel = _subtitleLabel,
			pubDateLabel = _pubDateLabel,
			episode_durationLabel = _episode_durationLabel,
			titleValue = _titleValue,
			authorValue = _authorValue,
			summaryValue = _summaryValue,
			subtitleValue = _subtitleValue,
			pubDateValue = _pubDateValue,
			episode_durationValue = _episode_durationValue;

//@synthesize avPlayer = avPlayer;

- (id)initWithRadioItem:(NSString *)placeholder query:(NSDictionary*)query
{
	if ((self = [self init])) {		
		// set the long name shown in the navigation bar at the top
		//self.navigationItem.title = [query objectForKey:@"title"];
		
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Radio"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.author = [query objectForKey:@"author"];
		self.subtitle = [query objectForKey:@"subtitle"];
		self.summary = [query objectForKey:@"summary"];
		self.pubDate = [query objectForKey:@"pubDate"];
		self.link = [query objectForKey:@"link"];
		self.episode_duration = [query objectForKey:@"episode_duration"];
		self.title_label = [query objectForKey:@"title_label"];
		self.subtitle_label = [query objectForKey:@"subtitle_label"];
		
		Touch320AppDelegate *appDelegate;
		appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
		
		appDelegate.link = self.link;
		appDelegate.activeViewController = self;
		
		NSLog(@"subtitle: %@",self.subtitle);
		NSLog(@"link: %@",self.link);
		
		/*
		[appDelegate bollocks]; 
		 
		NSLog(@"radio item title: %@",self.navigationItem.title);
		NSLog(@"radio item subtitle: %@",self.subtitle);
		NSLog(@"radio item author: %@",self.author);
		NSLog(@"radio item summary: %@",self.summary);
		NSLog(@"radio item episode_duration: %@",self.episode_duration);
		NSLog(@"radio item link: %@",self.link);
		NSLog(@"radio item pubDate: %@",self.pubDate);
		*/
	}
	
	return self;
}

- (id)init {
	if ((self = [super init])) {
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:YES];
	UINavigationBar *nb = self.navigationController.navigationBar;
	nb.tintColor = [UIColor colorWithRed:176/255.0 green:169/255.0 blue:18/255.0 alpha:1];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"radio-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"radio-nav"].CGImage;
	}	
}

- (void)viewDidLoad {
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	

	
  CGRect adjustedFrame = self.view.frame;
  if (!self.tabBarController.tabBar.hidden) adjustedFrame.size.height -= self.tabBarController.tabBar.frame.size.height;

	self.radioItemView = [[UIScrollView alloc] initWithFrame:adjustedFrame];
	self.radioItemView.backgroundColor = [UIColor whiteColor];
	
	[self.radioItemView setContentSize:CGSizeMake(self.view.frame.size.width, 2300)];
	
	[self.view addSubview:self.radioItemView];
	
	//subtitle value
	UILabel *subtitleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, appDelegate.deviceWidth - 20, 20)];
	subtitleValue.text = self.title_label;
	subtitleValue.textAlignment = UITextAlignmentLeft;
	subtitleValue.textColor = [UIColor blackColor];
	subtitleValue.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
	subtitleValue.backgroundColor = [UIColor whiteColor];
	subtitleValue.lineBreakMode = UILineBreakModeWordWrap;
	subtitleValue.adjustsFontSizeToFitWidth = YES;
	subtitleValue.numberOfLines = 0;
	
	subtitleValue.frame = [self resizeLabelFrame:subtitleValue
										 forText:self.title_label];
	
	[self.radioItemView addSubview:subtitleValue];
	[subtitleValue release];
	
	//title value
	UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, subtitleValue.frame.size.height + 5, appDelegate.deviceWidth - 20, 40)];
	titleValue.text = @"";
	titleValue.textAlignment = UITextAlignmentLeft;
	titleValue.textColor = [UIColor blackColor];
	titleValue.font = [UIFont fontWithName:@"Helvetica" size:12];
	titleValue.backgroundColor = [UIColor whiteColor];
	titleValue.lineBreakMode = UILineBreakModeWordWrap;
	titleValue.numberOfLines = 0;
	
	titleValue.frame = [self resizeLabelFrame:titleValue 
									  forText:@""];
	
	[self.radioItemView addSubview:titleValue];
	[titleValue release];
	
	//summary value
	UILabel *summaryValue = [[UILabel alloc] initWithFrame:CGRectMake(5, subtitleValue.frame.size.height + titleValue.frame.size.height + 10, appDelegate.deviceWidth - 20, 100)];
	summaryValue.text = self.summary;
	summaryValue.textAlignment = UITextAlignmentLeft;
	summaryValue.textColor = [UIColor blackColor];
	summaryValue.font = [UIFont fontWithName:@"Georgia" size:12];
	summaryValue.backgroundColor = [UIColor whiteColor];
	summaryValue.lineBreakMode = UILineBreakModeWordWrap;
	summaryValue.numberOfLines = 0;
	
	summaryValue.frame = [self resizeLabelFrame:summaryValue 
										forText:self.summary];
	
	[self.radioItemView addSubview:summaryValue];
	[summaryValue release];
	
	//button background images
	UIImage* blackBackgroundImage = [[UIImage imageNamed:@"blackbutton.png"] stretchableImageWithLeftCapWidth:12.0f topCapHeight:0.0f];
	
	//play button
	playButton = [UIButton buttonWithType:UIButtonTypeCustom];
	playButton.frame = CGRectMake(50, subtitleValue.frame.size.height + titleValue.frame.size.height + summaryValue.frame.size.height + 15, 200, 40);
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[playButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	playButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	playButton.backgroundColor = [UIColor clearColor];
	playButton.alpha = 1;
	[playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
	[self.radioItemView addSubview:playButton];
	
	//pause button
	pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	pauseButton.frame = CGRectMake(50, subtitleValue.frame.size.height + titleValue.frame.size.height + summaryValue.frame.size.height + 15, 200, 40);
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	[pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[pauseButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	pauseButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	pauseButton.backgroundColor = [UIColor clearColor];
	pauseButton.alpha = 0;
	[pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
	[self.radioItemView addSubview:pauseButton];
	
	//activityIndicatorView
	activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicatorView.center = CGPointMake(150, subtitleValue.frame.size.height + titleValue.frame.size.height + summaryValue.frame.size.height + 40);
	[self.radioItemView addSubview:activityIndicatorView];
  
  [self.radioItemView setContentSize:CGSizeMake(self.view.frame.size.width, subtitleValue.frame.size.height + titleValue.frame.size.height + summaryValue.frame.size.height + 15 + 40+20)];
	
  [self showLoading];
  [TJMAudioCenter instance].delegate = self;
  [[TJMAudioCenter instance]queueURL:[NSURL URLWithString:self.link]];
	
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.author = nil;
	self.summary = nil;
	self.pubDate = nil;
	self.link = nil;
	self.episode_duration = nil;
	self.title_label = nil;
	self.subtitle_label = nil;
	
	self.radioItemView = nil;
	
	self.titleLabel = nil;
	self.authorLabel = nil;
	self.subtitleLabel = nil;
	self.summaryLabel = nil;
	self.pubDateLabel = nil;
	self.episode_durationLabel = nil;
	
	self.titleValue = nil;
	self.authorValue = nil;
	self.subtitleValue = nil;
	self.summaryValue = nil;
	self.pubDateValue = nil;
	self.episode_durationValue = nil;
	
	playButton = nil;
	pauseButton = nil;
	activityIndicatorView = nil;
	
	[super viewDidUnload];
}


- (void)dealloc {
	TT_RELEASE_SAFELY(_author);
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_summary);
	TT_RELEASE_SAFELY(_pubDate);
	TT_RELEASE_SAFELY(_link);
	TT_RELEASE_SAFELY(_episode_duration);
	TT_RELEASE_SAFELY(_title_label);
	TT_RELEASE_SAFELY(_subtitle_label);
	
	TT_RELEASE_SAFELY(_radioItemView);
	
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_authorLabel);
	TT_RELEASE_SAFELY(_subtitleLabel);
	TT_RELEASE_SAFELY(_summaryLabel);
	TT_RELEASE_SAFELY(_pubDateLabel);
	TT_RELEASE_SAFELY(_episode_durationLabel);
	
	TT_RELEASE_SAFELY(_titleValue);
	TT_RELEASE_SAFELY(_authorValue);
	TT_RELEASE_SAFELY(_subtitleValue);
	TT_RELEASE_SAFELY(_summaryValue);
	TT_RELEASE_SAFELY(_pubDateValue);
	TT_RELEASE_SAFELY(_episode_durationValue);
	
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
//	Touch320AppDelegate *appDelegate;
//	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
//	
//	AudioSessionSetActive(YES);
//	
//	NSLog(@"active audio player: %@",[appDelegate activeAudioPlayer]);
//	
//	[appDelegate.activeAudioPlayer cancel];
//	appDelegate. activeAudioPlayer = nil;
//	
//	audioPlayer = [[AudioPlayer alloc] initPlayerWithURL:[NSURL URLWithString:self.link] delegate:self];
//	
//	appDelegate.activeAudioPlayer = audioPlayer;
//	
//	NSLog(@"active audio player: %@",[appDelegate activeAudioPlayer]);
  
  
  //[player addObserver:self forKeyPath:@"status" options:0 context:&PlayerStatusContext];
	
	//[self showLoading];
}

- (void)pause {
  [[TJMAudioCenter instance] pauseURL:[NSURL URLWithString:self.link]];
}

- (void)play {
  [[TJMAudioCenter instance] playURL:[NSURL URLWithString:self.link]];
}

- (void)audioPlayerDownloadFailed:(AudioPlayer *)audioPlayer {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Audio download failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
	[self showStopped];
}

- (void)audioPlayerPlaybackStarted:(AudioPlayer *)audioPlayer {
	NSLog(@"RadioItemViewController thinks playback has started");
	[self showPlaying];
}

- (void)audioPlayerPlaybackFinished:(AudioPlayer *)audioPlayer {
	NSLog(@"RadioItemViewController thinks playback has completed");
	AudioSessionSetActive(NO);
	[self showStopped];
}

#pragma mark TJM AudioCenterDelegate 
-(void)URLReadyToPlay:(NSURL *)url
{
  if ([[NSURL URLWithString:self.link] isEqual:url]) [self showPaused];
}

-(void)URLNotReadyToPlay:(NSURL *)url
{

}

-(void)URLIsPlaying:(NSURL *)url
{
  if ([[NSURL URLWithString:self.link] isEqual:url]) [self showPlaying];

}
-(void)URLIsPaused:(NSURL *)url
{
  if ([[NSURL URLWithString:self.link] isEqual:url]) [self showPaused];  
}

-(void)URLFailed:(NSURL *)url
{
  
}



@end
