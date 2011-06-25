//
//  TJMAudioCenter.h
//  Touch320
//
//  Created by Tim Medcalf on 25/06/2011.
//  Copyright 2011 ErgoThis Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
  TJMAudioStatusUnknown,
  TJMAudioStatusCurrentPlaying,
  TJMAudioStatusCurrentPaused,
  TJMAudioStatusCurrentFailed,
  TJMAudioStatusQueuedQueing,
  TJMAudioStatusQueuedReady,
  TJMTJMAudioStatusQueuedFailed
} TJMAudioStatus;

@interface TJMAudioCenter : NSObject

SINGLETON_INTERFACE_FOR(TJMAudioCenter)

@property (nonatomic, assign) TJMAudioStatus queueStatus;
@property (nonatomic, assign) TJMAudioStatus currentStatus;

- (void)playURL:(NSURL *)url;
- (void)queueURL:(NSURL *)url;

@end
