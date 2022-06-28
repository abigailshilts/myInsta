//
//  DetailsViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *caption;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.caption.text = self.passedData.caption;
    
    NSString *whenMade = [NSString stringWithFormat:@"%@", self.passedData.createdAt];
    self.timeStamp.text = whenMade;
    
    NSString *link = self.passedData.image.url;
    NSURL *url = [NSURL URLWithString:link];
    [self.postImg setImageWithURL:url];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
