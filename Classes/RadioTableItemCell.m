//
//  RadioTableItemCell.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RadioTableItemCell.h"
#import "RadioTableItem.h"

@implementation RadioTableItemCell

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForItem:(id)item { 
	return 100;
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
		
		//self.textLabel.text = [[object title] stringByAppendingString:[NSString stringWithFormat:@": %@", [object subtitle]]];
		self.textLabel.text = [object subtitle];
		self.textLabel.textColor = [UIColor blackColor]; 
		self.textLabel.font = [UIFont boldSystemFontOfSize:12]; 
		self.textLabel.textAlignment = UITextAlignmentLeft; 
		self.textLabel.contentMode = UIViewContentModeBottom; 
		self.textLabel.lineBreakMode = UILineBreakModeTailTruncation; 
		self.textLabel.numberOfLines = 0; 
		
		self.detailTextLabel.text = [object title];
		self.detailTextLabel.textColor = [UIColor grayColor]; 
		self.detailTextLabel.font = [UIFont boldSystemFontOfSize:12]; 
		self.detailTextLabel.textAlignment = UITextAlignmentLeft; 
		self.detailTextLabel.contentMode = UIViewContentModeTop; 
		self.detailTextLabel.lineBreakMode = UILineBreakModeTailTruncation; 
		self.detailTextLabel.numberOfLines = 0; 
		
		self.accessoryType = UITableViewCellAccessoryNone;
	}
} 

@end
