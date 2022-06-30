//
//  Post.m
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import "MIPost.h"
#import "stringsList.h"

@implementation MIPost
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return postStr;
}

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption:
    ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    MIPost *newPost = [MIPost new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
}

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // check if image is not nil
    if (!image) {
        return nil;
    }
    
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:ipng data:imageData];
}

@end
