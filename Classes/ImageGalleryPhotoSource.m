//
//  ImageGalleryPhotoSource.m
//  Touch320
//
//  Created by Dave Knapik on 15/12/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGalleryPhotoSource.h"
#import "SearchResult.h"

@interface PhotoItem : NSObject <TTPhoto>
{
    NSString *caption;
    NSString *imageURL;
    NSString *thumbnailURL;
    id <TTPhotoSource> photoSource;
    CGSize size;
    NSInteger index;
}
@property (nonatomic, retain) NSString *imageURL;
@property (nonatomic, retain) NSString *thumbnailURL;
+ (id)itemWithImageURL:(NSString*)imageURL thumbImageURL:(NSString*)thumbImageURL caption:(NSString*)caption size:(CGSize)size;
@end

// -----------------------------------------------------------------------
#pragma mark -

@implementation ImageGalleryPhotoSource

@synthesize title = albumTitle;

- (id)initWithModel:(FlickrSearchResultsModel *)theModel
{
    if ((self = [super init])) {
        albumTitle = @"Photos";
        model = [theModel retain];
    }
    return self;
}


// -----------------------------------------------------------------------
#pragma mark TTPhotoSource

- (NSInteger)numberOfPhotos 
{
    return [model totalResultsAvailableOnServer];
}

- (NSInteger)maxPhotoIndex
{
    return [[model results] count] - 1;
}

- (id<TTPhoto>)photoAtIndex:(NSInteger)index 
{
    if (index < 0 || index > [self maxPhotoIndex])
        return nil;
    
    // Construct an object (PhotoItem) that is suitable for Three20's
    // photo browsing system from the domain object (SearchResult)
    // at the specified index in the TTModel.
    SearchResult *result = [[model results] objectAtIndex:index];
    id<TTPhoto> photo = [PhotoItem itemWithImageURL:result.bigImageURL thumbImageURL:result.thumbnailURL caption:result.title size:result.bigImageSize];
    photo.index = index;
    photo.photoSource = self;
    return photo;
}

// -----------------------------------------------------------------------
#pragma mark -

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ delegates: %@", [super description], [self delegates]];
}

- (void)dealloc
{
    [model release];
    [albumTitle release];
    [super dealloc];
}

@end

// -----------------------------------------------------------------------
#pragma mark -

@implementation PhotoItem

@synthesize caption, photoSource, size, index; // properties declared in the TTPhoto protocol
@synthesize imageURL, thumbnailURL; // PhotoItem's own properties

+ (id)itemWithImageURL:(NSString*)theImageURL thumbImageURL:(NSString*)theThumbImageURL caption:(NSString*)theCaption size:(CGSize)theSize
{
    PhotoItem *item = [[[[self class] alloc] init] autorelease];
    item.caption = theCaption;
    item.imageURL = theImageURL;
    item.thumbnailURL = theThumbImageURL;
    item.size = theSize;
    return item;
}

// ----------------------------------------------------------
#pragma mark TTPhoto protocol

- (NSString*)URLForVersion:(TTPhotoVersion)version
{
    return (version == TTPhotoVersionThumbnail && thumbnailURL) 
    ? thumbnailURL
    : imageURL;
}

#pragma mark - 

- (void)dealloc
{
    [caption release];
    [imageURL release];
    [thumbnailURL release];
    [super dealloc];
}

@end
