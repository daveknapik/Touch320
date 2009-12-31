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

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(id)item { 
	return 40;
} 

- (void)dealloc {  
	[super dealloc];
}

// TTTableViewCell 

- (id)object { 
	return _item;
} 

- (void)setObject:(id)object { 
	if (_item != object) { 
		[super setObject:object]; 
		
		self.textLabel.textColor = [UIColor blackColor]; 
		self.textLabel.font = [UIFont boldSystemFontOfSize:12]; 
		self.textLabel.textAlignment = UITextAlignmentLeft; 
		self.textLabel.contentMode = UIViewContentModeCenter; 
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation; 
		self.textLabel.numberOfLines = 0; 
		self.accessoryType = UITableViewCellAccessoryNone;
	}
} 

@end
