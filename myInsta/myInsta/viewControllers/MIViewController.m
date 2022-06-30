//
//  ViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/27/22.
//

#import <Parse/Parse.h>
#import "stringsList.h"
#import "MIViewController.h"

@interface MIViewController ()

@end

@implementation MIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)signup:(id)sender {

        // creates an alert to display i n the event that fields are missing
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:missingFields message:logginginNeedsAll preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:okStr style:UIAlertActionStyleDefault
            handler:^(UIAlertAction * _Nonnull action) {}];
        [alert addAction:okAction];
        if ([self.username.text isEqual:empt] || [self.password.text isEqual:empt]){
            [self presentViewController:alert animated:YES completion:^{}];
        }

        PFUser *newUser = [PFUser user];
        
        newUser.username = self.username.text;
        newUser.password = self.password.text;
        
        // sends new user to database
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(errMsg, error.localizedDescription);
            } else {
                NSLog(registrationSuccessful);
                [self performSegueWithIdentifier:goToFeed sender:nil];
            }
        }];
}

- (IBAction)login:(id)sender {
    // creates an alert to display in the event that fields are missing
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:missingFields message:signingupRequiresAll preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okStr
        style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    if ([self.username.text isEqual:empt] || [self.password.text isEqual:empt]){
        [self presentViewController:alert animated:YES completion:^{}];
    }
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    // accesses user in database
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(usrLoginFailed, error.localizedDescription);
        } else {
            NSLog(userLoginSuccess);
            [self performSegueWithIdentifier:goToFeed sender:nil];
        }
    }];
}

@end
