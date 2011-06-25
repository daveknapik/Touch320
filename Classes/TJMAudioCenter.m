//
//  TJMAudioCenter.m
//  Touch320
//
//  Created by Tim Medcalf on 25/06/2011.
//  Copyright 2011 ErgoThis Ltd. All rights reserved.
//

#import "TJMAudioCenter.h"

NSString *const CurrentPlayerObserver = @"CurrentPlayerObserver";
NSString *const QueuedPlayerObserver = @"QueuedPlayerObserver";

@interface TJMAudioCenter ()
@property (nonatomic, retain) AVPlayer *playingPlayer;
@property (nonatomic, retain) AVPlayer *queuedPlayer;
@property (nonatomic, retain) NSURL *playingURL;
@property (nonatomic, retain) NSURL *queuedURL;


//-(void) initPlayer;
@end

@implementation TJMAudioCenter

@synthesize playingPlayer = _playingPlayer;
@synthesize queuedPlayer = _queuedPlayer;
@synthesize playingURL = _playingURL;
@synthesize queuedURL = _queuedURL;
@synthesize queueStatus = _queueStatus;
@synthesize currentStatus = _currentStatus;


SINGLETON_IMPLEMENTATION_FOR(TJMAudioCenter)

- (void)playURL:(NSURL*) url
{
  
  if ([self.playingURL isEqual:url]) return;
  if ([self.queuedURL isEqual:url])
  {
    if (self.queuedPlayer.currentItem.playbackBufferFull) NSLog(@"Playback buffer full");
    if (self.queuedPlayer.currentItem.playbackLikelyToKeepUp) NSLog(@"Playback likely to keep up");
    //NSLog(@"Status %d",self.queuedPlayer.status);
    if (self.queuedPlayer.status == AVPlayerItemStatusReadyToPlay)
    {
      {
        [self.playingPlayer removeObserver:self forKeyPath:@"status"];
        [self.playingPlayer pause];
        self.playingPlayer = nil;
        [self.queuedPlayer removeObserver:self forKeyPath:@"status"];
        self.playingPlayer = self.queuedPlayer;
        [self.playingPlayer addObserver:self forKeyPath:@"status" options:0 context:CurrentPlayerObserver];
        [self.playingPlayer play];
        self.queuedPlayer = nil;
      }
      self.playingURL = self.queuedURL;
      self.queuedURL = nil;
    }
  }
}

- (void)queueURL:(NSURL *)url
{
  if ([url isEqual:self.queuedURL]) return;
  self.queuedURL = url;
  [self.queuedPlayer removeObserver:self forKeyPath:@"status"];
  self.queuedPlayer = [AVPlayer playerWithURL:url];
  [self.queuedPlayer addObserver:self forKeyPath:@"status" options:0 context:QueuedPlayerObserver];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{ 
  if ([keyPath isEqualToString:@"status"]) 
  {
    if (context == QueuedPlayerObserver)
    {
      NSLog(@"Queue status : %i", self.queuedPlayer.status);
    }
    else
    {
      NSLog(@"Current status : %i", self.queuedPlayer.status);
    }
      
//    AVPlayerItem *item = (AVPlayerItem *)object;
//    if (item.status == AVPlayerItemStatusReadyToPlay) {
//      NSLog(@"Ready!!!!");
//    }
  }
}

-(void) dealloc
{
  [self.queuedPlayer removeObserver:self forKeyPath:@"status"];
  [_queuedPlayer release];
  [_playingPlayer release];
  [super dealloc];
}

@end
