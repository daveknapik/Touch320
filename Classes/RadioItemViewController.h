//
//  RadioItemViewController.h
//  Touch320
//
//  Created by Dave Knapik on 06/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>

@interface RadioItemViewController : TTViewController {
	NSString* _author;
	NSString* _subtitle;
	NSString* _summary;
	NSString* _pubDate;
	NSString* _link;
	NSString* _duration;
}

@property (nonatomic, copy) NSString* author;
@property (nonatomic, copy) NSString* summary;
@property (nonatomic, copy) NSString* subtitle;
@property (nonatomic, copy) NSString* pubDate;
@property (nonatomic, copy) NSString* link;
@property (nonatomic, copy) NSString* duration;

- (id)initWithRadioItem:(NSString *)placeholder query:(NSDictionary*)query;

@end
