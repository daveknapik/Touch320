//
//  Book.h
//  Touch320
//
//  Created by Dave Knapik on 14/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectiveResource.h"

@interface Book : NSObject {
	NSString *bookId;
	NSString *title;
	NSString *thoughts;
	NSDate   *updatedAt;
	NSDate   *createdAt;
}

@property (nonatomic, retain) NSString *bookId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *thoughts;
@property (nonatomic , retain) NSDate *createdAt;
@property (nonatomic , retain) NSDate *updatedAt;


@end
