//
//  ProfileViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/29/22.
//

#import "MIProfileViewController.h"
#import <Parse/Parse.h>
#import "MIPost.h"
#import "MIProfCell.h"
#import "stringsList.h"
#import "UIImageView+AFNetworking.h"

@interface MIProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<MIPost *> *arrayOfPosts;

@end

@implementation MIProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.username.text = PFUser.currentUser.username;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self query];
    // Do any additional setup after loading the view.
}

-(void)query {
    // creates query
    PFQuery *query = [PFQuery queryWithClassName:postStr];
    [query orderByDescending:createdAt];
    [query includeKey:authStr];
    PFUser *current = PFUser.currentUser;
    [query whereKey:authStr equalTo:current];

    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = posts;
            [self.tableView reloadData];
        } else {
            NSLog(makeStr, error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MIProfCell *cell = [tableView dequeueReusableCellWithIdentifier:profCell forIndexPath:indexPath];
    
    MIPost *post = self.arrayOfPosts[indexPath.row];
    
    // populates cell items
    NSString *link = post.image.url;
    NSURL *url = [NSURL URLWithString:link];
    cell.caption.text = post.caption;
    [cell.postImg setImageWithURL:url];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

@end
