//
//  AppDelegate.m
//  myInsta
//
//  Created by Abigail Shilts on 6/27/22.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "stringsList.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(  NSDictionary *)launchOptions {
    // Creates connection to the database
    ParseClientConfiguration *config =
        [ParseClientConfiguration  configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:keys ofType:plist];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        NSString *key = [dict objectForKey:appID];
        NSString *secret = [dict objectForKey:clientKey];
        
        configuration.applicationId = key;
        configuration.clientKey = secret;
        configuration.server = serverLink;
    }];

    [Parse initializeWithConfiguration:config];
    
    // builds an object
    PFObject *profile = [PFObject objectWithClassName:profileStr];
    profile[usrnameStr] = fillerusr;
    profile[screennameStr] = namefiller;
    profile[followersStr] = @500;
    [profile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(obSave);
        } else {
            NSLog(errMsg, error.description);
        }
    }];

    return YES;
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application
    configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
        options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
