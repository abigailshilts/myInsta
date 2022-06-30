//
//  DetailsViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import "MIDetailsViewController.h"
#import "stringsList.h"
#import "UIImageView+AFNetworking.h"

@interface MIDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UILabel *caption;

@end

@implementation MIDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // populates details view
    self.caption.text = self.passedData.caption;
    
    NSString *whenMade = [NSString stringWithFormat:makeStr, self.passedData.createdAt];
    self.timeStamp.text = whenMade;
    
    NSString *link = self.passedData.image.url;
    NSURL *url = [NSURL URLWithString:link];
    [self.postImg setImageWithURL:url];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
