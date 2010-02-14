//
//  RecipeBookCategoryTableItemCell.m
//  Touch320
//
//  Created by Dave Knapik on 13/02/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RecipeBookCategoryTableItemCell.h"
#import "RecipeBookCategoryTableItem.h"

@implementation RecipeBookCategoryTableItemCell

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