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
} TJMAudioStatus;

@protocol TJMAudioCenterDelegate <NSObject>
@optional
//-(void)URLReadyToPlay:(NSURL *)url;
-(void)URLIsPlaying:(NSURL *)url;
-(void)URLIsPaused:(NSURL *)url;
-(void)URLDidFail:(NSURL *)url;
-(void)URLDidFinish:(NSURL *) url;
@end

@interface TJMAudioCenter : NSObject

SINGLETON_INTERFACE_FOR(TJMAudioCenter)

@property (nonatomic, retain) id<TJMAudioCenterDelegate> delegate;

- (void)playURL:(NSURL *)url;
- (void)pauseURL:(NSURL *)url;

-(TJMAudioStatus)statusCheckForURL:(NSURL*) url;

@end
