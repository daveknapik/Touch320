//
//  AudioQueue.m
//

#import "AudioQueue.h"
#import "AudioPlayerUtil.h"

@implementation AudioQueue

@synthesize delegate;

void audioQueueOutputCallback (void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer);
void propertyChangeIsRunning(void *data, AudioQueueRef inAQ, AudioQueuePropertyID inID);

- (id)initQueueWithDelegate:(id<AudioQueueDelegate>)aDelegate {
	self = [super init];
	self.delegate = aDelegate;
	return self;
}

- (OSStatus)setAudioStreamBasicDescription:(AudioStreamBasicDescription)absd {
	OSStatus status = AudioQueueNewOutput(&absd, 
										  audioQueueOutputCallback, 
										  self, 
										  CFRunLoopGetCurrent(), 
										  kCFRunLoopCommonModes, 
										  0, 
										  &audioQueue);
	if (!VERIFY_STATUS(status)) {
		return status;
	}
	status = AudioQueueAddPropertyListener (audioQueue, kAudioQueueProperty_IsRunning, propertyChangeIsRunning, self);
	VERIFY_STATUS(status);
	return status;
}

- (OSStatus)setMagicCookie:(NSData *)magicCookie {
	return AudioQueueSetProperty(audioQueue, kAudioQueueProperty_MagicCookie, magicCookie.bytes, magicCookie.length);
}

- (OSStatus)start {
	return AudioQueueStart(audioQueue, NULL);
}

- (OSStatus)pause {
	return AudioQueuePause(audioQueue);
}

- (OSStatus)allocateBufferWithData:(NSData *)data 
					   packetCount:(UInt32)packetCount 
				packetDescriptions:(AudioStreamPacketDescription *)packetDescriptions
					  outBufferRef:(AudioQueueBufferRef *)outBufferRefPtr;
{
	OSStatus status = AudioQueueAllocateBufferWithPacketDescriptions(self->audioQueue, data.length, packetCount, outBufferRefPtr);

	if (VERIFY_STATUS(status)) {
		AudioQueueBufferRef outBufferRef = *outBufferRefPtr;
		memcpy(outBufferRef->mAudioData, data.bytes, data.length);
		outBufferRef->mAudioDataByteSize = data.length;
		memcpy(outBufferRef->mPacketDescriptions, packetDescriptions, sizeof(AudioStreamPacketDescription) * packetCount);	
		outBufferRef->mPacketDescriptionCount = packetCount;
	}

	return status;
}

- (OSStatus)enqueueBuffer:(AudioQueueBufferRef)bufferRef {
	OSStatus status = AudioQueueEnqueueBuffer(audioQueue, bufferRef, 0, NULL);	
	VERIFY_STATUS(status);
	return status;
}

void audioQueueOutputCallback (void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer) {
	AudioQueue *self = (AudioQueue *)inUserData;
	[self->delegate audioQueue:self isDoneWithBuffer:inBuffer];
}

- (OSStatus)endOfStream {
	OSStatus status = AudioQueueFlush(audioQueue);
	if (VERIFY_STATUS(status)) {
		status = AudioQueueStop(audioQueue, false);
		VERIFY_STATUS(status);
	}
	return status;
}

void propertyChangeIsRunning(void *data, AudioQueueRef inAQ, AudioQueuePropertyID inID) {
	AudioQueue *self = (AudioQueue *)data;
	
	int result = 0;
	UInt32 size = sizeof(UInt32);
	OSStatus status = AudioQueueGetProperty (self->audioQueue, kAudioQueueProperty_IsRunning, &result, &size);
	if (VERIFY_STATUS(status) && result == 0) {
		[self->delegate audioQueuePlaybackIsComplete:self];
	} else {
		[self->delegate audioQueuePlaybackIsStarting:self];
	}
}

- (void)dealloc {
	if (audioQueue != NULL) {
		VERIFY_STATUS(AudioQueueDispose(audioQueue, true));
	}
	[delegate release];
	[super dealloc];
}

@end
