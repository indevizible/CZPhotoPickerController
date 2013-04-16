// Copyright 2013 Care Zone Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <QuartzCore/QuartzCore.h>
#import "CZPhotoPickerController.h"
#import "CZViewController.h"

@interface CZViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *cropPreviewSwitch;
@property(nonatomic,weak) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) CZPhotoPickerController *pickPhotoController;
@end

@implementation CZViewController

#pragma mark - Methods

- (CZPhotoPickerController *)photoController
{
  __weak typeof(self) weakSelf = self;

  return [[CZPhotoPickerController alloc] initWithPresentingViewController:self withCompletionBlock:^(UIImagePickerController *imagePickerController, NSDictionary *imageInfoDict) {
    if (imagePickerController.allowsEditing) {
      weakSelf.imageView.image = imageInfoDict[UIImagePickerControllerEditedImage];
    }
    else {
      weakSelf.imageView.image = imageInfoDict[UIImagePickerControllerEditedImage];
    }

    if (weakSelf.modalViewController) {
      [weakSelf dismissViewControllerAnimated:YES completion:^{
        weakSelf.imageView.hidden = NO;
      }];
    }

    weakSelf.pickPhotoController = nil;
  }];
}

- (IBAction)takePicture:(id)sender
{
  self.pickPhotoController = [self photoController];

  if (self.cropPreviewSwitch.on) {
    self.pickPhotoController.allowsEditing = NO;
    self.pickPhotoController.cropOverlaySize = CGSizeMake(320, 100);
  }
  else {
    self.pickPhotoController.allowsEditing = YES;
    self.pickPhotoController.cropOverlaySize = CGSizeZero;
  }

  [self.pickPhotoController showFromBarButtonItem:sender];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.imageView.clipsToBounds = YES;

  self.imageView.layer.borderWidth = 1.0;
  self.imageView.layer.borderColor = [UIColor blackColor].CGColor;

  self.imageView.layer.cornerRadius = 5.0;

  self.imageView.hidden = YES;
}

@end
