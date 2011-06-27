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
release_title = _release_title,
release_description = _release_description,
subtitle = _subtitle,
release_duration = _release_duration,
mp3_sample_url = _mp3_sample_url,
cover_art_url = _cover_art_url,
itunes_url = _itunes_url,
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
	if ((self = [self init])) {		
		// set the long name shown in the navigation bar at the top
		
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Catalogue"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.release_title = [query objectForKey:@"subtitle"];
		self.artist = [query objectForKey:@"artist"];
		self.subtitle = [query objectForKey:@"title"];
		self.release_description = [query objectForKey:@"release_description"];
		self.release_duration = [query objectForKey:@"release_duration"];
		self.mp3_sample_url = [[query objectForKey:@"mp3_sample_url"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		//self.mp3_sample_url = @"http://www.daveknapik.com/audio/Silicon_Teens-Just_Like_Eddie.mp3";
		self.cover_art_url = [[query objectForKey:@"cover_art_url"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		self.itunes_url = [[query objectForKey:@"itunes_url"] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
		
		NSLog(@"%@",self.mp3_sample_url);
		NSLog(@"%@",self.itunes_url);
		Touch320AppDelegate *appDelegate;
		appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
		
		appDelegate.link = self.mp3_sample_url;
		appDelegate.activeViewController = self;
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
	nb.tintColor = [UIColor colorWithRed:82/255.0 green:96/255.0 blue:45/255.0 alpha:1];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		nb.layer.contents = (id)[UIImage imageNamed:@"catalog-nav-iPad"].CGImage;
	}
	else {
		nb.layer.contents = (id)[UIImage imageNamed:@"catalog-nav"].CGImage;
	}	
}

- (void)viewDidLoad {
  [super viewDidLoad];
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
  
  CGRect adjustedFrame = self.view.frame;
  if (!self.tabBarController.tabBar.hidden) adjustedFrame.size.height -= self.tabBarController.tabBar.frame.size.height;
  
	self.catalogItemView = [[UIScrollView alloc] initWithFrame:adjustedFrame];

	self.catalogItemView.backgroundColor = [UIColor whiteColor];
	
	[self.catalogItemView setContentSize:CGSizeMake(appDelegate.deviceWidth, 2300)];
	
	[self.view addSubview:self.catalogItemView];
	
	//button background images
	UIImage* blackBackgroundImage = [[UIImage imageNamed:@"blackbutton.png"] stretchableImageWithLeftCapWidth:12.0f topCapHeight:0.0f];
	UIImage* buyButtonGreen = [[UIImage imageNamed:@"buyButtonGreen.png"] stretchableImageWithLeftCapWidth:12.0f topCapHeight:0.0f];
	
	//initialize y-axis subview placement variable

	int previousSubviewHeight = 0;
	
	//subtitle value
  int yAxisPlacement = 5;
	
	UILabel *subtitleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 20)];
	subtitleValue.text = self.subtitle;
	subtitleValue.textAlignment = UITextAlignmentLeft;
	subtitleValue.textColor = [UIColor blackColor];
	subtitleValue.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
	subtitleValue.backgroundColor = [UIColor whiteColor];
	subtitleValue.lineBreakMode = UILineBreakModeWordWrap;
	subtitleValue.adjustsFontSizeToFitWidth = YES;
	subtitleValue.numberOfLines = 0;
	
	subtitleValue.frame = [self resizeLabelFrame:subtitleValue
										 forText:self.subtitle];
	
	[self.catalogItemView addSubview:subtitleValue];
	[subtitleValue release];
	previousSubviewHeight = subtitleValue.frame.size.height;
	
	//title value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 40)];
	titleValue.text = self.release_title;
	titleValue.textAlignment = UITextAlignmentLeft;
	titleValue.textColor = [UIColor blackColor];
	titleValue.font = [UIFont fontWithName:@"Helvetica" size:12];
	titleValue.backgroundColor = [UIColor whiteColor];
	titleValue.lineBreakMode = UILineBreakModeWordWrap;
	titleValue.numberOfLines = 0;
	
	titleValue.frame = [self resizeLabelFrame:titleValue 
									  forText:self.release_title];
	
	[self.catalogItemView addSubview:titleValue];
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
		
		[self.catalogItemView addSubview:cover_art];
		[cover_art release];
		previousSubviewHeight = cover_art.frame.size.height;
	//}
	
	//buy button
	if ([self.itunes_url length] != 0) {
		/*UILabel* buy_button = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 100)];
		buy_button.text = self.itunes_url;
		buy_button.textAlignment = UITextAlignmentLeft;
		buy_button.textColor = [UIColor blackColor];
		buy_button.font = [UIFont fontWithName:@"Georgia" size:12];
		buy_button.backgroundColor = [UIColor whiteColor];
		buy_button.lineBreakMode = UILineBreakModeWordWrap;
		buy_button.numberOfLines = 0;
		
		buy_button.frame = [self resizeLabelFrame:buy_button 
												forText:self.itunes_url];
		
		[self.view addSubview:buy_button];
		[buy_button release];
		previousSubviewHeight = buy_button.frame.size.height;*/
		
		buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
		buyButton.frame = CGRectMake(170, 42, 77, 32);
		[buyButton setTitle:@"Buy" forState:UIControlStateNormal];
		[buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[buyButton setBackgroundImage:buyButtonGreen forState:UIControlStateNormal];
		buyButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
		buyButton.backgroundColor = [UIColor clearColor];
		[buyButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
		[self.catalogItemView addSubview:buyButton];
	}
	
	//release_description value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *descriptionValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, appDelegate.deviceWidth - 20, 100)];
	descriptionValue.text = self.release_description;
	descriptionValue.textAlignment = UITextAlignmentLeft;
	descriptionValue.textColor = [UIColor blackColor];
	descriptionValue.font = [UIFont fontWithName:@"Georgia" size:12];
	descriptionValue.backgroundColor = [UIColor whiteColor];
	descriptionValue.lineBreakMode = UILineBreakModeWordWrap;
	descriptionValue.numberOfLines = 0;
	
	descriptionValue.frame = [self resizeLabelFrame:descriptionValue 
										forText:self.release_description];
	
	[self.catalogItemView addSubview:descriptionValue];
  previousSubviewHeight = descriptionValue.frame.size.height;
	[descriptionValue release];

	
	//BUTTONS
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	//play button
	playButton = [UIButton buttonWithType:UIButtonTypeCustom];
	playButton.frame = CGRectMake(170, 75, 77, 32);
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[playButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	playButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	playButton.backgroundColor = [UIColor clearColor];
	playButton.alpha = 1;
	[playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
	
	//pause button
	pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
	pauseButton.frame = CGRectMake(170, 75, 77, 32);
	[pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	[pauseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[pauseButton setBackgroundImage:blackBackgroundImage forState:UIControlStateNormal];
	pauseButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	pauseButton.backgroundColor = [UIColor clearColor];
	pauseButton.alpha = 0;
	[pauseButton addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
	
	//activityIndicatorView
	activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activityIndicatorView.center = CGPointMake(208, 95);
	
	//if ([self.mp3_sample_url length] != 0) {
		[self.catalogItemView addSubview:playButton];
		[self.catalogItemView addSubview:pauseButton];
		[self.catalogItemView addSubview:activityIndicatorView];
  
  [self.catalogItemView setContentSize:CGSizeMake(self.view.frame.size.width, yAxisPlacement + 10)];
		
  [TJMAudioCenter instance].delegate = self;
  //check we're not already playing
  if ([[TJMAudioCenter instance] statusCheckForURL:[NSURL URLWithString:self.mp3_sample_url]] == TJMAudioStatusCurrentPlaying)
    [self showPlaying];
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

- (void)buttonClicked {
	NSLog(@"%@",self.itunes_url);
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.itunes_url]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.artist = nil;
	self.release_title = nil;
	self.release_description = nil;
	self.release_duration = nil;
	self.mp3_sample_url = nil;
	self.cover_art_url = nil;
	self.itunes_url = nil;
	
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
	buyButton = nil;
	activityIndicatorView = nil;
	_cover_art = nil;
	
	[super viewDidUnload];
}


- (void)dealloc {
  
  //remove self from the beign the audio delegate - if its us
  if ([TJMAudioCenter instance].delegate == self) 
    [TJMAudioCenter instance].delegate = nil;
  
	TT_RELEASE_SAFELY(_artist);
	TT_RELEASE_SAFELY(_release_title);
	TT_RELEASE_SAFELY(_subtitle);
	TT_RELEASE_SAFELY(_release_description);
	TT_RELEASE_SAFELY(_release_duration);
	TT_RELEASE_SAFELY(_mp3_sample_url);
	TT_RELEASE_SAFELY(_cover_art_url);
	TT_RELEASE_SAFELY(_itunes_url);
	
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
	TT_RELEASE_SAFELY(buyButton);
	TT_RELEASE_SAFELY(activityIndicatorView);
	TT_RELEASE_SAFELY(_cover_art);
	
	[super dealloc];
}

- (void)showStopped {
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
  [UIView beginAnimations:nil context:nil];
  [activityIndicatorView stopAnimating];
  pauseButton.alpha = 1;
  playButton.alpha = 0;
  [UIView commitAnimations];
}

- (void)showPaused {
	[UIView beginAnimations:nil context:nil];
	[activityIndicatorView stopAnimating];
	pauseButton.alpha = 0;
	playButton.alpha = 1;
	[UIView commitAnimations];
}


- (void)pause {
  [[TJMAudioCenter instance] pauseURL:[NSURL URLWithString:self.mp3_sample_url]];
}

- (void)play {
  [[TJMAudioCenter instance] playURL:[NSURL URLWithString:self.mp3_sample_url]];}



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

#pragma mark TJM AudioCenterDelegate 
-(void)URLDidFinish:(NSURL *)url
{
  if ([[NSURL URLWithString:self.mp3_sample_url] isEqual:url]) [self showPaused];
}

-(void)URLIsPlaying:(NSURL *)url
{
  if ([[NSURL URLWithString:self.mp3_sample_url] isEqual:url]) [self showPlaying];
  
}
-(void)URLIsPaused:(NSURL *)url
{
  if ([[NSURL URLWithString:self.mp3_sample_url] isEqual:url]) [self showPaused];  
}

-(void)URLDidFail:(NSURL *)url
{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Audio stream failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert autorelease];
}


@end

