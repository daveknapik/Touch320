//
//  NewsTableItemCell.m
//  Touch320
//
//  Created by Dave Knapik on 29/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewsTableItemCell.h"
#import "NewsTableItem.h"

@implementation NewsTableItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)item {  
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return 87;
	}
	else {
		return 58;
	}
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		_item = nil;
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:_titleLabel];
		
		_subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[self.contentView addSubview:_subtitleLabel];
		
		_totem = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"go"]];  
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
	
	// Set the size, font, foreground color, background color
	_titleLabel.textColor = [UIColor blackColor]; 
	_titleLabel.textAlignment = UITextAlignmentLeft; 
	_titleLabel.contentMode = UIViewContentModeCenter; 
	_titleLabel.lineBreakMode = UILineBreakModeTailTruncation; 
	_titleLabel.numberOfLines = 0; 
	
	
	_subtitleLabel.textColor = [UIColor grayColor]; 
	_subtitleLabel.textAlignment = UITextAlignmentLeft; 
	_subtitleLabel.contentMode = UIViewContentModeCenter; 
	_subtitleLabel.lineBreakMode = UILineBreakModeTailTruncation; 
	_subtitleLabel.numberOfLines = 0;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		//iPad
		[_titleLabel setFrame:CGRectMake(50,20,535,25)];
		[_subtitleLabel setFrame:CGRectMake(50,45,535,22)];
		[_totem setFrame:CGRectMake(673, 19, 45, 45)];
		
		_titleLabel.font = [UIFont fontWithName:@"Helvetica" size:21]; 
		_subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15]; 
	}
	else {
		//iPhone
		[_titleLabel setFrame:CGRectMake(17,16,247,15)];
		[_subtitleLabel setFrame:CGRectMake(17,31,247,15)];
		[_totem setFrame:CGRectMake(273, 14, 30, 30)];
		
		_titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14]; 
		_subtitleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10]; 
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
