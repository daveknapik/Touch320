//
//  AudioFileStream.m
//

#import "AudioFileStream.h"
#import "AudioPlayerUtil.h"

@implementation AudioFileStream

@synthesize delegate;

// These are declarations for callbacks used by our AudioFileStream.  In both cases,
// they simply forward the call onto the self object that created the file stream.
void propertyCallback(void *clientData, AudioFileStreamID stream, AudioFileStreamPropertyID property, UInt32 *ioFlags);
void packetCallback(void *clientData, UInt32 byteCount, UInt32 packetCount, const void *inputData, AudioStreamPacketDescription *packetDescriptions);

- (id)initFileStreamWithDelegate:(id<AudioFileStreamDelegate>)aDelegate {
	self = [super init];
	self.delegate = aDelegate;
	return self;
}

- (OSStatus) open {
	// Open our file stream.  Our callback methods are implemented above.
	// We pass our self as clientData so that our callbacks simply message 
	// us when called, thus providing a simple Objective-C wrapper around
	// the C API.
	// We pass 0 as a fileTypeHint because CoreAudio is pretty good at
	// determining the fileType for us (and may ignore our hint anyway.)
	return AudioFileStreamOpen(self, 
							   propertyCallback, 
							   packetCallback, 
							   0, 
							   &streamID);
}

- (OSStatus)parseBytes:(NSData *)data {
	// Callbacks resulting from the parse may have errors,
	// so we'll use callbackStatus to keep track of those
	// errors and return as appropriate from this call.
	callbackStatus = noErr;

	// Our property and packet callbacks will
	// be called as a result of parsing bytes here.
	OSStatus status = AudioFileStreamParseBytes(streamID, 
												data.length, 
												data.bytes, 
												0);

	if (!VERIFY_STATUS(status)) {
		return status;
	}
	
	// Parsing happens synchronously, so any callbacks for this parse have 
	// already been called.  Rather than call our delegate back 
	// asynchronously with any errors, we'll instead return the error here.
	return callbackStatus;
}

- (void)notifyDelegateWithMagicCookie {	
	// This method is called when our propertyCallback is called
	// as a result of parsing bytes.
	
	// First, we need to fine out how big our magic cookie is.
	UInt32 size;
	Boolean writeable;
	callbackStatus = AudioFileStreamGetPropertyInfo(streamID, 
													kAudioFileStreamProperty_MagicCookieData, 
													&size, 
													&writeable);
	if (!VERIFY_STATUS(callbackStatus)) {
		return;
	}
	
	// Now we get the actual magic cookie data and send it to our delegate.
	NSMutableData *data = [NSMutableData dataWithLength:size];
	callbackStatus = AudioFileStreamGetProperty(streamID, 
												kAudioFileStreamProperty_MagicCookieData, 
												&size, 
												data.mutableBytes);
	if (!VERIFY_STATUS(callbackStatus)) {
		return;
	}
	
	[delegate audioFileStream:self foundMagicCookie:data];
}

- (void)notifyDelegateWithASBD {
	// For AAC-PLUS, the returned audio may actually have multiple supported formats, support for which may
	// vary based on the device.  Therefore we need to do some juggling here to figure out what we support.
	
	// We want to get a list of formats this audio stream supports.
	// Before we can that, we need to find the size of data we're trying to get.
	UInt32 formatListSize;
	Boolean b;
	AudioFileStreamGetPropertyInfo(streamID, 
								   kAudioFileStreamProperty_FormatList, 
								   &formatListSize, 
								   &b);
	
	// now get the format data
	NSMutableData *listData = [NSMutableData dataWithLength:formatListSize];
	OSStatus status = AudioFileStreamGetProperty(streamID, 
												 kAudioFileStreamProperty_FormatList, 
												 &formatListSize, 
												 [listData mutableBytes]);
	AudioFormatListItem *formatList = [listData mutableBytes];
	
	AudioStreamBasicDescription asbd;
	// The formatList property isn't always supported, so an error isn't unexpected here.
	// Therefore, we won't call VERIFY_STATUS on this status code.
	if (status == noErr) {
		// now see which format this device supports best
		UInt32 chosen;
		UInt32 chosenSize = sizeof(UInt32);
		int formatCount = formatListSize/sizeof(AudioFormatListItem);
		status = AudioFormatGetProperty ('fpfl', 
										 formatListSize, 
										 formatList, 
										 &chosenSize, 
										 &chosen);
		if (VERIFY_STATUS(status)) {
			asbd = formatList[chosen].mASBD;
		} else {
			// the docs tell us to grab the last in the list because it's most compatible
			asbd = formatList[formatCount - 1].mASBD;
		}
	} else {
		// fall back to the stream's DataFormat
		UInt32 descriptionSize = sizeof(AudioStreamBasicDescription);
		callbackStatus = AudioFileStreamGetProperty(streamID, 
													kAudioFileStreamProperty_DataFormat, 
													&descriptionSize, 
													&asbd);
		if (!VERIFY_STATUS(callbackStatus)) {
			return;
		}
	}
	
	[delegate audioFileStream:self isReadyToProducePacketsWithASBD:asbd];
}

- (void)propertyDidChange:(AudioFileStreamPropertyID)property {
	if (callbackStatus != noErr) {
		// We had a previous error during the current parse.  We should
		// stop processing this parse.
		return;
	}
	
	// This method is called by our propertyCallback
	switch (property) {
		case kAudioFileStreamProperty_MagicCookieData:
			// Our stream contains a "magic cookie".  Magic cookies contain special
			// metadata about the stream that is specific to the audio format in
			// a non-generalizable way.  AudioQueue requires the magic cookie
			// for some audio formats to work correctly.
			[self notifyDelegateWithMagicCookie];
			break;
		case kAudioFileStreamProperty_ReadyToProducePackets:
			// Enough data has been read from our stream to know the audio format
			// and begin sending audio data to an audio queue.  Notify our delegate
			// of the AudioStreamBasicDescriptor of this stream so that our delegate
			// can create and stream to an AudioQueue.
			[self notifyDelegateWithASBD];
			break;
		default:
			break;
	}
}

- (void)didProducePackets:(AudioStreamPacketDescription *)packetDescriptions 
		withPacketCount:(UInt32)packetCount 
			   fromData:(const void *)inputData
		   andByteCount:(UInt32)byteCount 
{
	// We've received packets from our audio queue.  Forward them onto our
	// delegate for queuing and playback.
	[delegate audioFileStream:self 
			didProducePackets:[NSData dataWithBytes:inputData length:byteCount]
					withCount:packetCount
			  andDescriptions:packetDescriptions];
}	

void propertyCallback(void *clientData,
					  AudioFileStreamID stream,
					  AudioFileStreamPropertyID property,
					  UInt32 *ioFlags)
{
	// forward the call onto the self object that created the file stream
	AudioFileStream *self = (AudioFileStream *)clientData;
	[self propertyDidChange:property];
}

void packetCallback(void *clientData,
					UInt32 byteCount,
					UInt32 packetCount,
					const void *inputData,
					AudioStreamPacketDescription *packetDescriptions)
{
	// forward the call onto the self object that created the file stream
	AudioFileStream *self = (AudioFileStream *)clientData;
	[self didProducePackets:packetDescriptions 
			withPacketCount:packetCount 
				   fromData:inputData 
			   andByteCount:byteCount];
}

- (void)dealloc {
	if (streamID != NULL) {
		OSStatus status = AudioFileStreamClose(streamID);
		VERIFY_STATUS(status);
	}
	[delegate release];
	[super dealloc];
}
@end
