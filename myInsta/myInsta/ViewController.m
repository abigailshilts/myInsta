//
//  ViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/27/22.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)signup:(id)sender {
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing field(s)" message:@"Loggiing in requires all fields to be filled" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:okAction];
        if ([self.username.text isEqual:@""] || [self.password.text isEqual:@""]){
            [self presentViewController:alert animated:YES completion:^{}];
        }
        // initialize a user object
        PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.username.text;
        newUser.password = self.password.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"goToFeed" sender:nil];
            }
        }];
}

- (IBAction)login:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing field(s)" message:@"Signing up requires all fields to be filled" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    if ([self.username.text isEqual:@""] || [self.password.text isEqual:@""]){
        [self presentViewController:alert animated:YES completion:^{}];
    }
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"goToFeed" sender:nil];
        }
    }];
}

@end
