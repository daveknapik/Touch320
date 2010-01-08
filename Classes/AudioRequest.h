//
//  AudioRequest.h
//

#import <Foundation/Foundation.h>

@protocol AudioRequestDelegate;
@interface AudioRequest : NSObject {
	NSURLConnection *connection;
	id<AudioRequestDelegate> delegate;
}

@property (nonatomic, retain) id<AudioRequestDelegate> delegate;

- (id)initRequestWithURL:(NSURL *)url delegate:(id<AudioRequestDelegate>)delegate;

/*
 * Cancels the request, guaranteeing that no further delegate messages will be sent.
 */
- (void)cancel;
@end

@protocol AudioRequestDelegate<NSObject>
/*
 * Notifies the delegate when we've received bytes from the network.
 */
- (void)audioRequest:(AudioRequest *)request didReceiveData:(NSData *)data;

/*
 * Notifies the delegate when there are no more bytes to deliver.
 */
- (void)audioRequestDidFinish:(AudioRequest *)request;
@end
