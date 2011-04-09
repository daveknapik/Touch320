//
//  BannerImageTableCell.m
//  Touch320
//
//  Created by David Knapik on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Touch320AppDelegate.h"
#import "BannerImageTableCell.h"
#import "BannerImageTableItem.h"

@implementation BannerImageTableCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)item {  
	return 125;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)identifier {
	if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier]) {
		_item = nil;
		
		_banner = [[UIImageView alloc] initWithFrame:CGRectZero];  
        [self.contentView addSubview:_banner];  

	}
	
	return self;
}

- (void)dealloc {  
	TT_RELEASE_SAFELY(_banner);
	[super dealloc];
}

#pragma mark -
#pragma mark UIView

- (void)layoutSubviews {
	[super layoutSubviews];
	
	Touch320AppDelegate *appDelegate;
	
	appDelegate = (Touch320AppDelegate*)[UIApplication sharedApplication].delegate;	
	
	if (appDelegate.deviceWidth == 320) {
		[_banner setFrame:CGRectMake(0, 0, 320, 125)];
	}
	else if (appDelegate.deviceWidth == 768) {
		[_banner setFrame:CGRectMake(0, 0, 768, 300)];
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
		
		BannerImageTableItem *item = object;
		_banner.image = item.banner;
	}
}

@end
