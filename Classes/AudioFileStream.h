//
//  AudioFileStream.h
//
// This is a very simple Objective-C wrapper around the
// AudioFileStream C API.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@protocol AudioFileStreamDelegate;
@interface AudioFileStream : NSObject {
	AudioFileStreamID streamID;
	id<AudioFileStreamDelegate> delegate;
	OSStatus callbackStatus;
}

@property (nonatomic,retain) id<AudioFileStreamDelegate> delegate;

- (id)initFileStreamWithDelegate:(id<AudioFileStreamDelegate>)delegate;

/*
 * Opens this file stream for parsing.
 * Returns an error code if an error occurs.  See documentation for 
 * AudioFileStreamOpen for possible errors.
 */
- (OSStatus)open;

/*
 * Parses bytes from this audio stream.
 * Delegate will be notified asynchronously of any magic cookie, 
 * AudioStreamBasicDescription, or packet data resulting from this
 * parsing call.  All asynchronous notifications will happen before
 * this method returns.
 *
 * Returns an error code if an error occurs.  See documentation for
 * AudioFileStreamParseBytes, AudioFileStreamGetPropertyInfo, or
 * AudioFileStreamGetProperty for possible errors.  Errors from this 
 * method are generally unexpected.  If one occurs, it is probably
 * best not to continue parsing with this AudioFileStream object.
 */
- (OSStatus)parseBytes:(NSData *)data;
@end

@protocol AudioFileStreamDelegate<NSObject>
/*
 * Some audio formats have "magic cookies" which contain special
 * metadata about the stream that is specific to the audio format in
 * a non-generalizable way.  AudioQueue requires the magic cookie
 * for such audio formats to work correctly.  This method notifies
 * a delegate if a magic cookie is found when parsing an AudioFileStream.
 */
- (void)audioFileStream:(AudioFileStream *)stream foundMagicCookie:(NSData *)cookie;

/*
 * This method notifies a delegate when an AudioFileStream is about to
 * begin sending packets.  It is a signal to the delegate that the stream
 * is valid, and the delegate should now create an AudioQueue and prepare
 * it for queining and playback.
 */
- (void)audioFileStream:(AudioFileStream *)stream isReadyToProducePacketsWithASBD:(AudioStreamBasicDescription)absd;

/*
 * This method notfies a delegate that new packets have been parsed from
 * the stream and are ready for queuing in an AudioQueue.
 */
- (void)audioFileStream:(AudioFileStream *)stream 
	  didProducePackets:(NSData *)packetData 
			  withCount:(UInt32)packetCount 
		andDescriptions:(AudioStreamPacketDescription *)packetDescriptions;
@end 
