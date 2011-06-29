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
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) NSURL *URL;
@property (nonatomic, assign) BOOL playWhenLoaded;
@property (nonatomic, assign) BOOL interruptedDuringPlayback;
- (void) setupAudioSession;
@end

@implementation TJMAudioCenter

@synthesize player = _player;
@synthesize URL = _URL;
@synthesize delegate = _delegate;
@synthesize playWhenLoaded = _playWhenLoaded;
@synthesize interruptedDuringPlayback = _interruptedDuringPlayback;

-(id) init
{
  if ((self = [super init]))
  {
    [self setupAudioSession];
  }
  return self;
}


SINGLETON_IMPLEMENTATION_FOR(TJMAudioCenter)

#pragma mark lifecycle  
-(void) dealloc
{
  [self.player removeObserver:self forKeyPath:@"rate"];
  [self.player.currentItem removeObserver:self forKeyPath:@"status"];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
  
  [_player release];
  [_URL release];
  
  [super dealloc];
}


- (void)playURL:(NSURL*) url
{
  NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
  //if url matches existing playing item, just makes sure it's playing
  if ([self.URL isEqual:url]) 
  {
    self.player.rate = 1;
    NSLog(@"[%@ %@] Rate =1", [self class], NSStringFromSelector(_cmd));
  }
  else
  {
    NSLog(@"[%@ %@] New url", [self class], NSStringFromSelector(_cmd));
    //remove notifications
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    [self.player removeObserver:self forKeyPath:@"rate"];
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    //create a new AVPlayer
    self.playWhenLoaded = YES;
    self.player = [AVPlayer playerWithURL:url];
    self.URL = url;
    //reinstate notifications
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:0 context:CurrentPlayerObserver];
    [self.player addObserver:self forKeyPath:@"rate" options:0 context:CurrentPlayerObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.player.currentItem];
  }
}

- (void)pauseURL:(NSURL *)url
{
  NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
  if ([self.URL isEqual:url])
  {
    self.player.rate = 0;
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
      if (self.player.currentItem.status == AVPlayerStatusFailed)
      {
        [self.delegate URLDidFail:self.URL];
        NSLog(@"Audio Failed");
      }
      else if (self.playWhenLoaded && (self.player.currentItem.status == AVPlayerStatusReadyToPlay))
      {
        NSLog(@"Audio Ready To PLay");
        self.player.rate = 1;
        self.playWhenLoaded = NO;
      }
    }
  }
  else if ([keyPath isEqualToString:@"rate"])
  {
    if ([(NSString*)context isEqual: CurrentPlayerObserver])
    {
      if (self.player.rate == 0)
      {
        NSLog(@"Audio Paused");
        [self.delegate URLIsPaused:self.URL];
      }
      else
      {
        NSLog(@"Audio Playing");
        [self.delegate URLIsPlaying:self.URL];
      }
    }
  }
}

-(TJMAudioStatus)statusCheckForURL:(NSURL*)url;
{
  if ([self.URL isEqual:url])
  {
    if (self.player.currentItem.status == AVPlayerStatusReadyToPlay) 
    {
      return (self.player.rate == 1) ? TJMAudioStatusCurrentPlaying : TJMAudioStatusCurrentPaused;
    }
    if (self.player.currentItem.status == AVPlayerStatusFailed) return TJMAudioStatusCurrentFailed;
    //otherwise
    NSLog(@"Error - playingPlayer.currentItem status unknown - this shouldn't happen");
  }
  
  return TJMAudioStatusUnknown;
}

#pragma mark notifications
//reset the stream to the start and pause it when it reaches the end, ready to play again.
- (void)playerItemDidReachEnd:(NSNotification *)notification {
  NSLog(@"Reached end of stream...");
  if (self.player)
  {
    [self.player seekToTime:kCMTimeZero];
    self.player.rate = 0;
  }
}

- (void) setupAudioSession {
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
  AVAudioSession *mySession = [AVAudioSession sharedInstance];
  
  // Specify that this object is the delegate of the audio session, so that
  //    this object's endInterruption method will be invoked when needed.
  [mySession setDelegate: self];
  
  // Assign the Playback category to the audio session.
  NSError *audioSessionError = nil;
  [mySession setCategory: AVAudioSessionCategoryPlayback
                   error: &audioSessionError];
  
  if (audioSessionError != nil) {
    
    NSLog (@"Error setting audio session category.");
    return;
  }
  
  
  // Activate the audio session
  [mySession setActive: YES
                 error: &audioSessionError];
  
  if (audioSessionError != nil) {
    
    NSLog (@"Error activating audio session during initial setup.");
    return;
  }
  
}

#pragma mark audiosession delegate
- (void)beginInterruption
{
  NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
  self.interruptedDuringPlayback = (self.player.rate == 1);
}

- (void)endInterruptionWithFlags:(NSUInteger)flags
{
    NSLog(@"[%@ %@]", [self class], NSStringFromSelector(_cmd));
  // Test if the interruption that has just ended was one from which this app 
  //    should resume playback.
  if (flags & AVAudioSessionInterruptionFlags_ShouldResume) {
    
    NSError *endInterruptionError = nil;
    if ([[AVAudioSession sharedInstance] setActive: YES
                                         error: &endInterruptionError])
    {
      NSLog (@"Audio session reactivated after interruption.");
    
      if (self.interruptedDuringPlayback) {
        NSLog (@"Restarting playback.");
        self.interruptedDuringPlayback = NO;
        self.player.rate = 1.0;
      }
    }
    else
    {
      NSLog (@"Unable to reactivate the audio session after the interruption ended - %@",endInterruptionError);
      return;
    }
  }
}


@end
