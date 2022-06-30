//
//  ProfCell.h
//  myInsta
//
//  Created by Abigail Shilts on 6/29/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MIProfCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UILabel *caption;

@end

NS_ASSUME_NONNULL_END
