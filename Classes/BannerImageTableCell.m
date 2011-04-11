//
//  BannerImageTableCell.m
//  Touch320
//
//  Created by David Knapik on 4/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BannerImageTableCell.h"
#import "BannerImageTableItem.h"

@implementation BannerImageTableCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)item {  
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return 307;
	}
	else {
		return 125;
	}
	
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
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[_banner setFrame:CGRectMake(0, 0, 768, 307)];
	}
	else {
		[_banner setFrame:CGRectMake(0, 0, 320, 125)];
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
		
		NSLog(@"image width: %d",item.banner.size);
	}
}

@end
