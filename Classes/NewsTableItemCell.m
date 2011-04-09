//
//  NewsTableItemCell.m
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Touch320AppDelegate.h"
#import "NewsTableItemCell.h"
#import "NewsTableItem.h"

@implementation NewsTableItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)item {  
	return 58.0;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		_item = nil;
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:_titleLabel];
		
		_subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:_subtitleLabel];
		
		_totem = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"news"]];  
        [self.contentView addSubview:_totem];
	}
	
	return self;
}

- (void)dealloc {  
	TT_RELEASE_SAFELY(_titleLabel);
	TT_RELEASE_SAFELY(_subtitleLabel);
	TT_RELEASE_SAFELY(_totem);
	[super dealloc];
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews {
	[super layoutSubviews];
	
	Touch320AppDelegate *appDelegate;
	
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;	
	
	// Set the size, font, foreground color, background color
	_titleLabel.textColor = [UIColor blackColor]; 
	_titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14]; 
	_titleLabel.textAlignment = UITextAlignmentLeft; 
	_titleLabel.contentMode = UIViewContentModeCenter; 
	_titleLabel.lineBreakMode = UILineBreakModeTailTruncation; 
	_titleLabel.numberOfLines = 0; 
	
	
	_subtitleLabel.textColor = [UIColor grayColor]; 
	_subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10]; 
	_subtitleLabel.textAlignment = UITextAlignmentLeft; 
	_subtitleLabel.contentMode = UIViewContentModeCenter; 
	_subtitleLabel.lineBreakMode = UILineBreakModeTailTruncation; 
	_subtitleLabel.numberOfLines = 0;

	if (appDelegate.deviceWidth == 320) {
		[_titleLabel setFrame:CGRectMake(24,16,237,15)];
		[_subtitleLabel setFrame:CGRectMake(24,31,237,15)];
		[_totem setFrame:CGRectMake(261, 9, 30, 30)];
	}
	else if (appDelegate.deviceWidth == 768) {
		[_titleLabel setFrame:CGRectMake(58,16,568,15)];
		[_subtitleLabel setFrame:CGRectMake(58,31,568,15)];
		[_totem setFrame:CGRectMake(626, 9, 30, 30)];
	}
	
}

#pragma mark -
#pragma mark TTTableViewCell

- (id)object {
	return _item;  
}

- (void)setObject:(id)object {
	if (_item != object) {
		[super setObject:object];
		
		NewsTableItem *item = object;
		
		// Set the data in various UI elements
		[_titleLabel setText:item.title];
		[_subtitleLabel setText:item.pubDate];
	}
}

@end
