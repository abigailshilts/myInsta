//
//  DetailsViewController.h
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "MIPost.h"
NS_ASSUME_NONNULL_BEGIN

@interface MIDetailsViewController : UIViewController
@property (strong, nonatomic) MIPost *passedData;
@end

NS_ASSUME_NONNULL_END
