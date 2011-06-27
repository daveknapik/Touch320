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

#pragma mark lifecycle
-(void) dealloc
{
  [self.queuedPlayer.currentItem removeObserver:self forKeyPath:@"status"];
  [self.playingPlayer removeObserver:self forKeyPath:@"rate"];
  [self.playingPlayer.currentItem removeObserver:self forKeyPath:@"status"];
  
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playingPlayer];
  
  [_queuedPlayer release];
  [_playingPlayer release];

  [super dealloc];
}


- (void)playURL:(NSURL*) url
{
  //if url matches existing playing item, just makes sure it's playing
  if ([self.playingURL isEqual:url]) self.playingPlayer.rate = 1;
  //if we're queued & ready, start the playback
  if ([self.queuedURL isEqual:url])
  {
    if (self.queuedPlayer.currentItem.status == AVPlayerItemStatusReadyToPlay)
    {
      //kill any existing playback stuff
      [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playingPlayer];
      [self.playingPlayer removeObserver:self forKeyPath:@"rate"];
      [self.playingPlayer.currentItem removeObserver:self forKeyPath:@"status"];
      [self.playingPlayer pause];
      self.playingPlayer = nil;
      //swap the queuedPlayer into the playing one.
      [self.queuedPlayer.currentItem removeObserver:self forKeyPath:@"status"];
      self.playingPlayer = self.queuedPlayer;
      [self.playingPlayer.currentItem addObserver:self forKeyPath:@"status" options:0 context:CurrentPlayerObserver];
      [self.playingPlayer addObserver:self forKeyPath:@"rate" options:0 context:CurrentPlayerObserver];
      self.playingURL = self.queuedURL;
      self.queuedURL = nil;
      self.queuedPlayer = nil;
      //register to be notified when the playback reaches the end of the stream
       [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(playerItemDidReachEnd:)
        name:AVPlayerItemDidPlayToEndTimeNotification
        object:self.playingPlayer];
      //start playback;
      [self.playingPlayer play];
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
  //if the url we've been asked to queue is already playing, inform the delegate and return
  if (([url isEqual:self.playingURL]) && (self.playingPlayer.currentItem.status != AVPlayerStatusFailed))
  {
    if (self.playingPlayer.rate == 0)
    {
      if (self.delegate) [self.delegate URLIsPaused:self.playingURL];
    }
    else
    {
      if (self.delegate) [self.delegate URLIsPlaying:self.playingURL];
    }
    return;
  }
  
  //if the url we've been asked to queue is already in the queue inform the delegate and return
  if (([url isEqual:self.queuedURL]) && (self.queuedPlayer.currentItem.status != AVPlayerStatusFailed)) 
  {
    if (self.queuedPlayer.currentItem.status == AVPlayerStatusReadyToPlay)
    {
      if (self.delegate) [self.delegate URLReadyToPlay:self.queuedURL];
    }
    return; 
  }
  
  //otherwise set up the url in the queued player object
  self.queuedURL = url;
  [self.queuedPlayer.currentItem removeObserver:self forKeyPath:@"status"];
  self.queuedPlayer = [AVPlayer playerWithURL:url];
  [self.queuedPlayer.currentItem addObserver:self forKeyPath:@"status" options:0 context:QueuedPlayerObserver];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{ 
  if ([keyPath isEqualToString:@"status"])
  {
    //if we aint got a delegate just return - we've got no-one to inform!
    if (!self.delegate) return;
      
    if ([(NSString*)context isEqual: QueuedPlayerObserver])
    {
      switch (self.queuedPlayer.currentItem.status)
      {
        case AVPlayerStatusUnknown:
          [self.delegate URLNotReadyToPlay:self.queuedURL];
          break;
        case AVPlayerStatusReadyToPlay:
          NSLog(@"RTP %i",self.queuedPlayer.currentItem.status);
          [self.delegate URLReadyToPlay:self.queuedURL];
          break;
        case AVPlayerStatusFailed:
        default:
          [self.delegate URLQueueFailed:self.queuedURL];
      }
    }
    else
    {
      if (([(NSString*)context isEqual: CurrentPlayerObserver]) && (self.playingPlayer.currentItem.status == AVPlayerStatusFailed))
        [self.delegate URLPlayFailed:self.queuedURL];  
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

-(TJMAudioStatus)statusCheckForURL:(NSURL*) url
{
  if ([self.playingURL isEqual:url])
  {
    if (self.playingPlayer.currentItem.status == AVPlayerStatusReadyToPlay) 
    {
      return (self.playingPlayer.rate == 1) ? TJMAudioStatusCurrentPlaying : TJMAudioStatusCurrentPaused;
    }
    if (self.playingPlayer.currentItem.status == AVPlayerStatusFailed) return TJMAudioStatusCurrentFailed;
    //otherwise
    NSLog(@"Error - playingPlayer.currentItem status unknown - this shouldn't happen");
    return TJMAudioStatusUnknown;
  }
  
  if ([self.queuedURL isEqual:url])
  {
    if (self.queuedPlayer.currentItem.status == AVPlayerStatusUnknown) return TJMAudioStatusQueuedQueing;
    if (self.queuedPlayer.currentItem.status == AVPlayerStatusReadyToPlay) return TJMAudioStatusQueuedReady;
    if (self.queuedPlayer.currentItem.status == AVPlayerStatusFailed) return TJMAudioStatusQueuedFailed;
  }
    
  return TJMAudioStatusUnknown;
}

#pragma mark notifications
//reset the stream to the start and pause it when it reaches the end, ready to play again.
- (void)playerItemDidReachEnd:(NSNotification *)notification {
  if (self.playingPlayer)
  {
    NSLog(@"Reached end of stream...");
    [self.playingPlayer seekToTime:kCMTimeZero];
    self.playingPlayer.rate = 0;
  }
}



@end