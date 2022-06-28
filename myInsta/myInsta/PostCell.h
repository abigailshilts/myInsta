//
//  PostCell.h
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UILabel *caption;

@end

NS_ASSUME_NONNULL_END
