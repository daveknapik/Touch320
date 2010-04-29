//
//  FlickrJSONResponse.h
//
//  based on http://github.com/klazuka/TTRemoteExamples

#import <Three20/Three20+Additions.h>

@interface FlickrJSONResponse : NSObject <TTURLResponse>
{
	NSMutableArray* objects;
	NSUInteger totalObjectsAvailableOnServer;
}

@property (nonatomic, readonly) NSMutableArray *objects;
@property (nonatomic, readonly) NSUInteger totalObjectsAvailableOnServer;

@end
