//
//  RecipeBookItemViewController.m
//  Touch320
//
//  Created by Dave Knapik on 14/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookItemViewController.h"
#import "Touch320AppDelegate.h"

@implementation RecipeBookItemViewController

@synthesize author = _author, 
			recipe_title = _recipe_title,
			recipe_description = _recipe_description,
			titleValue = _titleValue,
			authorValue = _authorValue,
			descriptionValue = _descriptionValue,
			recipeItemView = _recipeItemView;

- (id)initWithRecipeItem:(NSString *)placeholder query:(NSDictionary*)query
{
	if (self = [self init]) {		
		// set the long name shown in the navigation bar at the top
		self.navigationItem.title=@"";
		
		self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Recipes"
																				  style:UIBarButtonItemStyleBordered
																				 target:nil
																				 action:nil] autorelease];
		
		self.navigationBarStyle = UIBarStyleDefault; 
		self.navigationBarTintColor	= [UIColor blackColor];
		self.statusBarStyle = UIStatusBarStyleBlackOpaque;
		
		self.author = [query objectForKey:@"author"];
		self.recipe_title = [query objectForKey:@"title"];
		self.recipe_description = [query objectForKey:@"recipe_description"];
		
		if ([MFMailComposeViewController canSendMail]) {
			self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStylePlain target:self action:@selector(sendRecipe)] autorelease];
		}
		/* NSLog(@"recipe item title: %@",self.recipe_title);
		NSLog(@"recipe item author: %@",self.author);
		NSLog(@"recipe item description: %@",self.recipe_description); */
	}
	
	return self;
}

- (id)init {
	if (self = [super init]) {
	}
	return self;
}

- (void)viewDidLoad {
	self.recipeItemView.delegate = self;
	
	Touch320AppDelegate *appDelegate;
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;
	
	self.recipeItemView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, appDelegate.deviceWidth, appDelegate.deviceHeight - 114)];
	
	NSString *recipeHTML = [NSString stringWithFormat:@"<meta name=\"viewport\" content=\"width=device-width\" />"];
	
	recipeHTML = [recipeHTML stringByAppendingString:@"<link rel=\"stylesheet\" media=\"only screen and (max-device-width: 480px)\" href=\"http://www.daveknapik.com/dropbox/mobile.css\" />"];
	recipeHTML = [recipeHTML stringByAppendingString:@"<link rel=\"stylesheet\" media=\"only screen and (min-device-width: 481px) and (max-device-width: 1024px)\" href=\"http://www.daveknapik.com/dropbox/ipad.css\" />"];
	
	recipeHTML = [recipeHTML stringByAppendingString:@"<p id='title'><strong>"];
	recipeHTML = [recipeHTML stringByAppendingString:self.recipe_title];
	recipeHTML = [recipeHTML stringByAppendingString:@"</strong>"];
	
	recipeHTML = [recipeHTML stringByAppendingString:@"<br />by "];
	recipeHTML = [recipeHTML stringByAppendingString:self.author];
	recipeHTML = [recipeHTML stringByAppendingString:@"</p>"];
	
	//recipeHTML = [recipeHTML stringByAppendingString:@"<p><a href=\"http://itunes.apple.com/us/album/a-hidden-place/id417727682?uo=4\" target=\"itunes_store\">A Hidden Place - Sohrab</a></p>"];
	
	recipeHTML = [recipeHTML stringByAppendingString:self.recipe_description];
	
	[self.recipeItemView loadHTMLString:recipeHTML baseURL:nil];
	
	self.recipeItemView.scalesPageToFit = YES;
	self.recipeItemView.autoresizesSubviews = YES;
	
	[self.view addSubview:self.recipeItemView];
	
	
	/*self.view = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 2300)];
	[self.view setContentSize:CGSizeMake(320,2300)];
	
	self.recipeItemView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 2300)];
	self.recipeItemView.backgroundColor = [UIColor whiteColor];
	
	[self.recipeItemView setContentSize:CGSizeMake(320, 2300)];
	
	[self.view addSubview:self.recipeItemView];
	
	//initialize y-axis subview placement variable
	int yAxisPlacement = 0;
	int previousSubviewHeight = 0;
	
	//title value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *titleValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, 300, 40)];
	titleValue.text = self.navigationItem.title;
	titleValue.textAlignment = UITextAlignmentLeft;
	titleValue.textColor = [UIColor blackColor];
	titleValue.font = [UIFont boldSystemFontOfSize:12];
	titleValue.backgroundColor = [UIColor whiteColor];
	titleValue.lineBreakMode = UILineBreakModeWordWrap;
	titleValue.numberOfLines = 0;
	
	titleValue.frame = [self resizeLabelFrame:titleValue 
									  forText:self.navigationItem.title];
	
	[self.view addSubview:titleValue];
	[titleValue release];
	previousSubviewHeight = titleValue.frame.size.height;
	
	//author value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *authorValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, 300, 20)];
	authorValue.text = [@"by " stringByAppendingString:self.author];
	authorValue.textAlignment = UITextAlignmentLeft;
	authorValue.textColor = [UIColor blackColor];
	authorValue.font = [UIFont systemFontOfSize:12];
	authorValue.backgroundColor = [UIColor whiteColor];
	authorValue.lineBreakMode = UILineBreakModeWordWrap;
	authorValue.adjustsFontSizeToFitWidth = YES;
	authorValue.numberOfLines = 0;
	
	authorValue.frame = [self resizeLabelFrame:authorValue 
									   forText:self.author];
	
	[self.view addSubview:authorValue];
	[authorValue release];
	previousSubviewHeight = authorValue.frame.size.height;
	
	//recipe_description value
	yAxisPlacement = yAxisPlacement + previousSubviewHeight + 5;
	
	UILabel *descriptionValue = [[UILabel alloc] initWithFrame:CGRectMake(5, yAxisPlacement, 300, 100)];
	descriptionValue.text = self.recipe_description;
	descriptionValue.textAlignment = UITextAlignmentLeft;
	descriptionValue.textColor = [UIColor blackColor];
	descriptionValue.font = [UIFont systemFontOfSize:12];
	descriptionValue.backgroundColor = [UIColor whiteColor];
	descriptionValue.lineBreakMode = UILineBreakModeWordWrap;
	descriptionValue.numberOfLines = 0;
	
	descriptionValue.frame = [self resizeLabelFrame:descriptionValue 
											forText:self.recipe_description];
	
	[self.view addSubview:descriptionValue];
	[descriptionValue release];
	previousSubviewHeight = descriptionValue.frame.size.height;*/
	
	NSLog(self.recipe_description);
	
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

- (void)sendRecipe {
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	
	NSString *subject = [NSString stringWithFormat:@"A recipe cooked up by "];
	subject = [subject stringByAppendingString:self.author];
	subject = [subject stringByAppendingString:@" for Touch"];
	
	NSString *recipeHTML = [NSString stringWithFormat:@"<p id='title'><strong>"];
	recipeHTML = [recipeHTML stringByAppendingString:self.recipe_title];
	recipeHTML = [recipeHTML stringByAppendingString:@"</strong>"];
	recipeHTML = [recipeHTML stringByAppendingString:@"<br />by "];
	recipeHTML = [recipeHTML stringByAppendingString:self.author];
	recipeHTML = [recipeHTML stringByAppendingString:@"</p>"];
	recipeHTML = [recipeHTML stringByAppendingString:self.recipe_description];
	
	[controller setSubject:subject];
	[controller setMessageBody:recipeHTML isHTML:YES];
	
	[self presentModalViewController:controller animated:YES];
	
	[[controller navigationBar] setTintColor:[UIColor blackColor]];	
	[controller release];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self becomeFirstResponder];
	[self dismissModalViewControllerAnimated:YES];
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.author = nil;
	self.recipe_title = nil;
	self.recipe_description = nil;
	
	self.recipeItemView = nil;
	
	self.titleValue = nil;
	self.authorValue = nil;
	self.descriptionValue = nil;
	
	[super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
	TT_RELEASE_SAFELY(_author);
	TT_RELEASE_SAFELY(_recipe_title);
	TT_RELEASE_SAFELY(_recipe_description);
	
	TT_RELEASE_SAFELY(_titleValue);
	TT_RELEASE_SAFELY(_authorValue);
	TT_RELEASE_SAFELY(_descriptionValue);
	
	TT_RELEASE_SAFELY(_recipeItemView);
	
	[super dealloc];
}


@end
