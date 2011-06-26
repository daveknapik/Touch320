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
  TJMAudioStatusQueuedFailed
} TJMAudioStatus;

@protocol TJMAudioCenterDelegate <NSObject>
@optional
-(void)URLReadyToPlay:(NSURL *)url;
-(void)URLNotReadyToPlay:(NSURL *)url;
-(void)URLIsPlaying:(NSURL *)url;
-(void)URLIsPaused:(NSURL *)url;
-(void)URLFailed:(NSURL *)url;
@end

@interface TJMAudioCenter : NSObject

SINGLETON_INTERFACE_FOR(TJMAudioCenter)

@property (nonatomic, assign) TJMAudioStatus queueStatus;
@property (nonatomic, assign) TJMAudioStatus currentStatus;
@property (nonatomic, retain) id<TJMAudioCenterDelegate> delegate;

- (void)playURL:(NSURL *)url;
- (void)pauseURL:(NSURL *)url;
- (void)queueURL:(NSURL *)url;

@end
