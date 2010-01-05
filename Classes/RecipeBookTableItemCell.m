//
//  RecipeBookTableItemCell.m
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookTableItemCell.h"
#import "RecipeBookTableItem.h"


@implementation RecipeBookTableItemCell

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

