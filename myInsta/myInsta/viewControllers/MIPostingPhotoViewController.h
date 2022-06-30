//
//  PostingPhotoViewController.h
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MIPostingPhotoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UITextField *caption;
@property (weak, nonatomic) UIImage *imgForPost;
@end

NS_ASSUME_NONNULL_END
