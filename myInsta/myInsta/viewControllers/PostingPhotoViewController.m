//
//  PostingPhotoViewController.m
//  myInsta
//
//  Created by Abigail Shilts on 6/28/22.
//

#import "PostingPhotoViewController.h"
#import "Post.h"

@interface PostingPhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation PostingPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];

    // Do any additional setup after loading the view.
}

- (IBAction)makePost:(id)sender {
    [Post postUserImage:self.imgForPost withCaption:self.caption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"posted photo!");
        [self performSegueWithIdentifier:@"closeCreatePost" sender:nil];
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
