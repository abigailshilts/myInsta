//
//  FeedViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/27/22.
//

#import "FeedViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<Post *> *arrayOfPosts;
@property (strong, nonatomic) UIRefreshControl*refreshControl;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"headerViewIdentifier"];
    
    [self query];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(query) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    // Do any additional setup after loading the view.
}
- (IBAction)postPhoto:(id)sender {
    [self performSegueWithIdentifier:@"postPhoto" sender:nil];
}

-(void)query {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    if (self.arrayOfPosts != nil){
        [query whereKey:@"createdAt" lessThan:self.arrayOfPosts[self.arrayOfPosts.count-1].createdAt];
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
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"postCell" forIndexPath:indexPath];
    
    Post *post = self.arrayOfPosts[indexPath.section];
    
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
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerViewIdentifier"];
    Post *post =  self.arrayOfPosts[section];
    PFUser *user = post.author;
    NSString *username = [user.username stringByAppendingString:@"~"];
    NSString *whenMade = [NSString stringWithFormat:@"%@", post.createdAt];
    header.textLabel.text = [username stringByAppendingString:whenMade];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (IBAction)logout:(id)sender {
    SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginViewController =
        [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    mySceneDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {}];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == (self.arrayOfPosts.count - 2)){
        [self query];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue.identifier isEqualToString:@"postPhoto"]){
        NSIndexPath *senderIndex = [self.tableView indexPathForCell: sender];
        UINavigationController *navigationVC = [segue destinationViewController];
        DetailsViewController *detailVC = navigationVC.topViewController;
        Post *post = self.arrayOfPosts[senderIndex.row];
        detailVC.passedData = post;
    }
}


@end
