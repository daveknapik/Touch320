//
//  AudioPlayer.m
//

#import "AudioPlayer.h"


@implementation AudioPlayer

- (id)initPlayerWithURL:(NSURL *)url delegate:(id<AudioPlayerDelegate>) aDelegate {
	self = [super init];

	delegate = aDelegate;
	
	queue = [[AudioQueue alloc] initQueueWithDelegate:self];

	fileStream = [[AudioFileStream alloc] initFileStreamWithDelegate:self];
	[fileStream open];

	request = [[AudioRequest alloc] initRequestWithURL:url delegate:self];

	return self;
}

- (void)error {
	[self cancel];
	[delegate audioPlayerDownloadFailed:self];
}

- (void)audioRequest:(AudioRequest *)request didReceiveData:(NSData *)data {
	if ([fileStream parseBytes:data] != noErr) {
		[self error];
	}
}

- (void)audioRequestDidFinish:(AudioRequest *)request {
	if (!audioIsReadyToPlay) {
		[self error];
	}
}

- (void)audioFileStream:(AudioFileStream *)stream foundMagicCookie:(NSData *)cookie {
	// if an error happens here, it may be recoverable so we let it slide...
	[queue setMagicCookie:cookie];
}

- (void)audioFileStream:(AudioFileStream *)stream isReadyToProducePacketsWithASBD:(AudioStreamBasicDescription)absd {
	if ([queue setAudioStreamBasicDescription:absd] == noErr) {
		audioIsReadyToPlay = YES;
		if (!paused) {
			[queue start];
		}
	} else {
		[self error];
	}
}

- (void)audioFileStream:(AudioFileStream *)stream 
	  didProducePackets:(NSData *)packetData 
			  withCount:(UInt32)packetCount 
		andDescriptions:(AudioStreamPacketDescription *)packetDescriptions
{
	AudioQueueBufferRef bufferRef;
	OSStatus status = [queue allocateBufferWithData:packetData 
										packetCount:packetCount 
								 packetDescriptions:packetDescriptions 
									   outBufferRef:&bufferRef];
	if (status == noErr) {
		[queue enqueueBuffer:bufferRef];
	} else {
		[self error];
	}
}

- (void)audioQueue:(AudioQueue *)audioQueue 
  isDoneWithBuffer:(AudioQueueBufferRef)bufferRef
{
	// nothing to do
}

- (void)audioQueuePlaybackIsStarting:(AudioQueue *)audioQueue {
	[delegate audioPlayerPlaybackStarted:self];
}

- (void)audioQueuePlaybackIsComplete:(AudioQueue *)audioQueue {
	[delegate audioPlayerPlaybackFinished:self];
}

- (BOOL)paused {
	return paused;
}

- (void)setPaused:(BOOL)b {
	if (b == paused) {
		return;
	}

	paused = b;
	if (!audioIsReadyToPlay) {
		return;
	}
	
	if (paused) {
		[queue pause];
	} else {
		[queue start];
	}
}

- (void)cancel {
	request.delegate = nil;
	[request cancel];
	[request release];
	
	fileStream.delegate = nil;
	[fileStream release];
	
	queue.delegate = nil;
	[queue release];

	// nil out our references so that any further operations
	// (such as cancel during dealloc) don't cause errors.
	request = nil;
	fileStream = nil;
	queue = nil;
}

- (void)dealloc {
	[self cancel];
	[super dealloc];
}

@end
