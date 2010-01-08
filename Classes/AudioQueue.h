//
//  AudioQueue.h
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@protocol AudioQueueDelegate;
@interface AudioQueue : NSObject {
	AudioQueueRef audioQueue;
	id<AudioQueueDelegate> delegate;
	AudioQueueBufferRef buffersHead;
	AudioQueueBufferRef buffersTail;
}

@property (nonatomic,retain) id<AudioQueueDelegate> delegate;

- (id)initQueueWithDelegate:(id<AudioQueueDelegate>)delegate;

/*
 * Sets the ASBD for this AudioQueue.  See Core Audio documentation
 * for AudioQueueNewOutput and AudioQueueSetProperty for possible
 * return values.
 */
- (OSStatus)setAudioStreamBasicDescription:(AudioStreamBasicDescription)absd;

/*
 * Sets the magic cookie for this audio queue.  See Core Audio documentation
 * for AudioQueueSetProperty for possible return values.
 */
- (OSStatus)setMagicCookie:(NSData *)magicCookie;

/*
 * Starts playback of the audio queue.  See Core Audio documentation
 * for AudioQueueStart for possible return values.
 */
- (OSStatus)start;

/*
 * Pauses playback of the audio queue.  See Core Audio documentation
 * for AudioQueuePause for possible return values.
 */
- (OSStatus)pause;

/*
 * Allocates a buffer for future queueing on this AudioQueue.
 * See Core Audio documentation for AudioQueueAllocateBufferWithPacketDescriptions
 * for possible return values;
 */
- (OSStatus)allocateBufferWithData:(NSData *)data 
					   packetCount:(UInt32)packetCount 
				packetDescriptions:(AudioStreamPacketDescription *)packetDescriptions
					  outBufferRef:(AudioQueueBufferRef *)outBufferRef;

/*
 * Enqueues a buffer for future playback.  See Core Audio documentation for 
 * AudioQueueEnqueueBuffer for possible return values;
 */
- (OSStatus)enqueueBuffer:(AudioQueueBufferRef)bufferRef;

/*
 * Notifies this AudioQueue that no more audio will be queued, and that
 * the AudioQueue should stop once the last currently queued buffer 
 * is complete. See Core Audio documentation for AudioQueueFlush and
 * AudioStop for possible return values;
 */
- (OSStatus)endOfStream;
@end



@protocol AudioQueueDelegate<NSObject>
/*
 * Notifies the delegate that the AudioQueue is done enqueueing a
 * buffer and the buffer may now be released.
 */
- (void)audioQueue:(AudioQueue *)audioQueue isDoneWithBuffer:(AudioQueueBufferRef)bufferRef;

/*
 * Notifies the delegate that audio is now playing on this AudioQueue.
 */
- (void)audioQueuePlaybackIsStarting:(AudioQueue *)audioQueue;

/*
 * Notifies the delegate that audio playback has finished
 * on this AudioQueue.
 */
- (void)audioQueuePlaybackIsComplete:(AudioQueue *)audioQueue;
@end
