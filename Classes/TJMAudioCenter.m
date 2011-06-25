//
//  TJMAudioCenter.m
//  Touch320
//
//  Created by Tim Medcalf on 25/06/2011.
//  Copyright 2011 ErgoThis Ltd. All rights reserved.
//

#import "TJMAudioCenter.h"

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


SINGLETON_IMPLEMENTATION_FOR(TJMAudioCenter)

- (void)playURL:(NSURL*) url
{
  
  if ([self.playingURL isEqual:url]) return;
  if ([self.queuedURL isEqual:url])
  {
    if (self.queuedPlayer.currentItem.playbackBufferFull) NSLog(@"Playback buffer full");
    if (self.queuedPlayer.currentItem.playbackLikelyToKeepUp) NSLog(@"Playback likely to keep up");
    NSLog(@"Status %d",self.queuedPlayer.status);
    //if (self.queuedItem.status == AVPlayerItemStatusReadyToPlay)
    {
//      if (!self.playingPlayer)
      {
        [self.playingPlayer pause];
        self.playingPlayer = nil;
        self.playingPlayer = self.queuedPlayer;
        [self.playingPlayer play];
        self.queuedPlayer = nil;
      }
//      else
 //       [self.player replaceCurrentItemWithPlayerItem:self.queuedItem];


      self.playingURL = self.queuedURL;
      self.queuedURL = nil;
    }

  }
  
//  if (self.player)
//    self.player = [AVPlayer playerWithURL:url];
//  else
//    [self.player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:url]];
//[self.player addObserver:self forKeyPath:@"status" options:0 context:&PlayerStatusContext];
}

- (void)queueURL:(NSURL *)url
{
  if ([url isEqual:self.queuedURL]) return;
  self.queuedURL = url;
  self.queuedPlayer = [AVPlayer playerWithURL:url];
  //[self.queuedItem addObserver:self forKeyPath:@"status" options:0 context:nil];
}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
//                        change:(NSDictionary *)change context:(void *)context
//{ 
//  if ([keyPath isEqualToString:@"status"]) {
//    AVPlayerItem *item = (AVPlayerItem *)object;
//    if (item.status == AVPlayerItemStatusReadyToPlay) {
//      NSLog(@"Ready!!!!");
//    }
//  }   
//}

-(void) dealloc
{
  [_queuedPlayer release];
  [_playingPlayer release];
  [super dealloc];
}

@end
