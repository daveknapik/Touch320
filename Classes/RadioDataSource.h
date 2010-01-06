//
//  RadioDataSource.h
//  Touch320
//
//  Created by Dave Knapik on 05/01/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Three20/Three20.h>
#import "RadioModel.h"


@interface RadioDataSource : TTListDataSource {
	RadioModel* _radioModel;
}

- (id)initWithModel;

@end
