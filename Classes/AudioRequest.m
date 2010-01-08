//
//  AudioRequest.m
//

#import "AudioRequest.h"


@implementation AudioRequest
@synthesize delegate;

static CFTimeInterval kTimeoutInterval = 15;

- (id)initRequestWithURL:(NSURL *)url delegate:(id<AudioRequestDelegate>)aDelegate {
	self = [super init];
	self.delegate = aDelegate;
	NSURLRequest *request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:kTimeoutInterval];
	connection = [[NSURLConnection connectionWithRequest:request delegate:self] retain];
	return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)aResponse {
	if ([aResponse isKindOfClass:[NSHTTPURLResponse class]]) {
		NSHTTPURLResponse *response = (NSHTTPURLResponse *)aResponse;
		if (response.statusCode >= 400) {
			NSLog(@"AudioRequest received error HTTP status code: %i", response.statusCode);
			[delegate audioRequestDidFinish:self];

			// prevent the delivery of any more bytes, which would not be audio bytes and
			// therefore could harm the audio subsystems.
			[self cancel];
		}
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)fromData {
	[delegate audioRequest:self didReceiveData:fromData];
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)error {
	NSLog(@"AudioRequest received NSError: %i", error.code);
	[self cancel];
	[delegate audioRequestDidFinish:self];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[self cancel];
	[delegate audioRequestDidFinish:self];
}

- (void)cancel {
	[connection cancel];
	[connection release];
	connection = nil;
}

- (void)dealloc {
	if (connection) {
		[self cancel];
	}
	[delegate release];
	[super dealloc];
}

@end
