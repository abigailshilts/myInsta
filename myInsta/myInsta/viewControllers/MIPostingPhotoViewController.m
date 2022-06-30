//
//  PostingPhotoViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import "MIPostingPhotoViewController.h"
#import "MIPost.h"
#import "stringsList.h"

@interface MIPostingPhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation MIPostingPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // calls image gallery and camera
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(noCameraMsg);
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];

    // Do any additional setup after loading the view.
}

- (IBAction)makePost:(id)sender {
    // sends post to database
    [MIPost postUserImage:self.imgForPost withCaption:self.caption.text
         withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(postedSuccess);
    }];
    // closes view immediatly to prevent sending multiple requests
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    //UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    
    originalImage = [self resizeImage:originalImage withSize:CGSizeMake(580,580)];

    // Do something with the images (based on your use case)
    [self.postImg setImage:originalImage];
    self.imgForPost = originalImage;
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
