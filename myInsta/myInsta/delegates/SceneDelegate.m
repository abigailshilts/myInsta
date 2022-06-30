//
//  SceneDelegate.m
//  myInsta
//
//  Created by Abigail Shilts on 6/27/22.
//

#import "Parse/Parse.h"
#import "SceneDelegate.h"
#import "stringsList.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    if (PFUser.currentUser) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:mainStr bundle:nil];
        
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:tabBar];
    }
}


@end
