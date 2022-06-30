//
//  FeedViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/27/22.
//
#import "MIDetailsViewController.h"
#import "MIFeedViewController.h"
#import <Parse/Parse.h>
#import "MIPostCell.h"
#import "MIPost.h"
#import "SceneDelegate.h"
#import "stringsList.h"
#import "UIImageView+AFNetworking.h"

@interface MIFeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<MIPost *> *arrayOfPosts;
@property (strong, nonatomic) UIRefreshControl*refreshControl;
@end

@implementation MIFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerViewId];
    
    // populates arrayOfPosts
    [self query];
    
    // creates refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(query) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}
- (IBAction)postPhoto:(id)sender {
    [self performSegueWithIdentifier:postPhoto sender:nil];
}

-(void)query {
    // creates query
    PFQuery *query = [PFQuery queryWithClassName:postStr];
    [query orderByDescending:createdAt];
    [query includeKey:authStr];
    if (self.arrayOfPosts != nil){
        [query whereKey:createdAt lessThan:self.arrayOfPosts[self.arrayOfPosts.count-1].createdAt];
    }
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            if (self.arrayOfPosts == nil){ 
                self.arrayOfPosts = posts;
            } else {
                self.arrayOfPosts = [self.arrayOfPosts arrayByAddingObjectsFromArray:posts];
            }
            [self.tableView reloadData];
        } else {
            NSLog(makeStr, error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MIPostCell *cell = [tableView dequeueReusableCellWithIdentifier:postCell forIndexPath:indexPath];
    
    MIPost *post = self.arrayOfPosts[indexPath.section];
    
    // sets cell properties to post properties
    NSString *link = post.image.url;
    NSURL *url = [NSURL URLWithString:link];
    cell.caption.text = post.caption;
    [cell.postImg setImageWithURL:url];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayOfPosts.count;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewId];
    MIPost *post = self.arrayOfPosts[section];
    PFUser *user = post.author;
    
    // creates header for each section
    NSString *username = [user.username stringByAppendingString:tild];
    NSString *whenMade = [NSString stringWithFormat:makeStr, post.createdAt];
    header.textLabel.text = [username stringByAppendingString:whenMade];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (IBAction)logout:(id)sender {
    SceneDelegate *mySceneDelegate = (SceneDelegate * )
        UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStr bundle:nil];
    UIViewController *loginViewController =
        [storyboard instantiateViewControllerWithIdentifier:logViewController];
    mySceneDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    // detirmines if more cells need to be loaded
    if (indexPath.section == (self.arrayOfPosts.count - 2)){
        [self query];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // sends information for populating detailsview
    if (![segue.identifier isEqualToString:postPhoto]){
        NSIndexPath *senderIndex = [self.tableView indexPathForCell: sender];
        UINavigationController *navigationVC = [segue destinationViewController];
        MIDetailsViewController *detailVC = navigationVC.topViewController;
        MIPost *post = self.arrayOfPosts[senderIndex.row];
        detailVC.passedData = post;
    }
}


@end
