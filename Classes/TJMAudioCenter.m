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
@synthesize delegate = _delegate;


SINGLETON_IMPLEMENTATION_FOR(TJMAudioCenter)

- (void)playURL:(NSURL*) url
{
  
  if ([self.playingURL isEqual:url]) self.playingPlayer.rate = 1;
  if ([self.queuedURL isEqual:url])
  {
    if (self.queuedPlayer.currentItem.playbackBufferFull) NSLog(@"Playback buffer full");
    if (self.queuedPlayer.currentItem.playbackLikelyToKeepUp) NSLog(@"Playback likely to keep up");
    //NSLog(@"Status %d",self.queuedPlayer.status);
    if (self.queuedPlayer.status == AVPlayerItemStatusReadyToPlay)
    {
      {
        //kill any existing playback stuff
        [self.playingPlayer removeObserver:self forKeyPath:@"rate"];
        [self.playingPlayer removeObserver:self forKeyPath:@"status"];
        [self.playingPlayer pause];
        self.playingPlayer = nil;
        //swap the queuedPlayer into the playing one.
        [self.queuedPlayer removeObserver:self forKeyPath:@"status"];
        self.playingPlayer = self.queuedPlayer;
        [self.playingPlayer addObserver:self forKeyPath:@"status" options:0 context:CurrentPlayerObserver];
        [self.playingPlayer addObserver:self forKeyPath:@"rate" options:0 context:CurrentPlayerObserver];
        self.playingURL = self.queuedURL;
        self.queuedURL = nil;
        [self.playingPlayer play];
        self.queuedPlayer = nil;
      }

    }
  }
}

- (void)pauseURL:(NSURL *)url
{
  if ([self.playingURL isEqual:url])
  {
    self.playingPlayer.rate = 0;
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
    //NSLog(@"%@",(NSString*)context);
    if ([(NSString*)context isEqual: QueuedPlayerObserver])
    {
      if ((self.queuedPlayer.status == AVPlayerStatusReadyToPlay) && (self.delegate))
      {
        [self.delegate URLReadyToPlay:self.queuedURL];
      }
      else
      {
        if (self.delegate) [self.delegate URLNotReadyToPlay:self.queuedURL];
      }
    }
    else
    {
      NSLog(@"Current status : %i", self.playingPlayer.status);
    }
  }
  else if ([keyPath isEqualToString:@"rate"])
  {
    if ([(NSString*)context isEqual: CurrentPlayerObserver])
    {
      if (self.playingPlayer.rate == 0)
      {
        if (self.delegate) [self.delegate URLIsPaused:self.playingURL];
      }
      else
      {
        if (self.delegate) [self.delegate URLIsPlaying:self.playingURL];
      }
    }
  }
}

-(void) dealloc
{
  [self.queuedPlayer removeObserver:self forKeyPath:@"status"];
  [self.playingPlayer removeObserver:self forKeyPath:@"rate"];
  [self.playingPlayer removeObserver:self forKeyPath:@"status"];
  [_queuedPlayer release];
  [_playingPlayer release];
  [super dealloc];
}

@end
