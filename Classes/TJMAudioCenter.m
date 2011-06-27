//
//  TJMAudioCenter.m
//  Touch320
//
//  Created by Tim Medcalf on 25/06/2011.
//  Copyright 2011 ErgoThis Ltd. All rights reserved.
//

#import "TJMAudioCenter.h"

NSString *const CurrentPlayerObserver = @"CurrentPlayerObserver";

@interface TJMAudioCenter ()
@property (nonatomic, retain) AVPlayer *playingPlayer;
@property (nonatomic, retain) NSURL *playingURL;
@property (nonatomic, assign) BOOL playWhenLoaded;
@end

@implementation TJMAudioCenter

@synthesize playingPlayer = _playingPlayer;
@synthesize playingURL = _playingURL;
@synthesize delegate = _delegate;
@synthesize playWhenLoaded = _playWhenLoaded;


SINGLETON_IMPLEMENTATION_FOR(TJMAudioCenter)

#pragma mark lifecycle  
-(void) dealloc
{
  [self.playingPlayer removeObserver:self forKeyPath:@"rate"];
  [self.playingPlayer.currentItem removeObserver:self forKeyPath:@"status"];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playingPlayer.currentItem];
  
  [_playingPlayer release];
  [super dealloc];
}


- (void)playURL:(NSURL*) url
{
  //if url matches existing playing item, just makes sure it's playing
  if ([self.playingURL isEqual:url]) 
    self.playingPlayer.rate = 1;
  else
  {
    //remove notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playingPlayer.currentItem];
    [self.playingPlayer removeObserver:self forKeyPath:@"rate"];
    [self.playingPlayer.currentItem removeObserver:self forKeyPath:@"status"];
    //create a new AVPlayer
    self.playWhenLoaded = YES;
    self.playingPlayer = [AVPlayer playerWithURL:url];
    self.playingURL = url;
    //reinstate notifications
    [self.playingPlayer.currentItem addObserver:self forKeyPath:@"status" options:0 context:CurrentPlayerObserver];
    [self.playingPlayer addObserver:self forKeyPath:@"rate" options:0 context:CurrentPlayerObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.playingPlayer.currentItem];
  }
}

- (void)pauseURL:(NSURL *)url
{
  if ([self.playingURL isEqual:url])
  {
    self.playingPlayer.rate = 0;
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{ 
  //if we aint got a delegate just return - we've got no-one to inform!
  if (!self.delegate) return;
  
  if ([keyPath isEqualToString:@"status"])
  {
    if ([(NSString*)context isEqual: CurrentPlayerObserver])
    {
      if (self.playingPlayer.currentItem.status == AVPlayerStatusFailed)
        [self.delegate URLDidFail:self.playingURL];
      else if (self.playWhenLoaded && (self.playingPlayer.currentItem.status == AVPlayerStatusReadyToPlay))
      {
        self.playingPlayer.rate = 1;
        self.playWhenLoaded = NO;
      }
    }
      
  }
  else if ([keyPath isEqualToString:@"rate"])
  {
    if ([(NSString*)context isEqual: CurrentPlayerObserver])
    {
      if (self.playingPlayer.rate == 0)
        [self.delegate URLIsPaused:self.playingURL];      
      else
        [self.delegate URLIsPlaying:self.playingURL];
    }
  }
}

-(TJMAudioStatus)statusCheckForURL:(NSURL*)url;
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
  }
  
  return TJMAudioStatusUnknown;
}

#pragma mark notifications
//reset the stream to the start and pause it when it reaches the end, ready to play again.
- (void)playerItemDidReachEnd:(NSNotification *)notification {
  NSLog(@"Reached end of stream...");
  if (self.playingPlayer)
  {
    [self.playingPlayer seekToTime:kCMTimeZero];
    self.playingPlayer.rate = 0;
  }
}



@end
