//
//  AudioPlayer.h
//

#import <Foundation/Foundation.h>

#import "AudioRequest.h"
#import "AudioFileStream.h"
#import "AudioQueue.h"

@protocol AudioPlayerDelegate;

@interface AudioPlayer : NSObject <
	AudioRequestDelegate,
	AudioFileStreamDelegate,
	AudioQueueDelegate
> {
	id<AudioPlayerDelegate> delegate;
	AudioRequest *request;
	AudioFileStream *fileStream;
	AudioQueue *queue;
	BOOL audioIsReadyToPlay;
	BOOL paused;
}

@property (nonatomic) BOOL paused;

- (id)initPlayerWithURL:(NSURL *)url delegate:(id<AudioPlayerDelegate>) aDelegate;

/*
 * Cancels an audio request, guaranteeing that no further delegate messages are sent.
 */
- (void)cancel;
@end



@protocol AudioPlayerDelegate<NSObject>
/*
 * Notifies the delegate that the requested file was not playable.
 */
- (void)audioPlayerDownloadFailed:(AudioPlayer *)audioPlayer;

/*
 * Notifies the delegate that playback of the requested file has begun.
 */
- (void)audioPlayerPlaybackStarted:(AudioPlayer *)audioPlayer;

/*
 * Notifies the delegate that playback of the request file is complete.
 */
- (void)audioPlayerPlaybackFinished:(AudioPlayer *)audioPlayer;
@end
