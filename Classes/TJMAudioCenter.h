//
//  TJMAudioCenter.h
//  Touch320
//
//  Created by Tim Medcalf on 25/06/2011.
//  Copyright 2011 ErgoThis Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJMAudioCenter : NSObject

SINGLETON_INTERFACE_FOR(TJMAudioCenter)

- (void)playURL:(NSURL *)url;
- (void)queueURL:(NSURL *)url;

@end
