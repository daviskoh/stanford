//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Davis Koh on 12/29/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

@end

@implementation ImageViewController

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    // below is blocking as its fetching from Internet
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
}

- (UIImageView *)imageView {
    if (!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

// NOTE no @synthesize needed EVEN THOUGH overriding getter/setter
// because NOT using instance var
- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;

    // ** UIImageView will adjust frame to fit image **
    [self.imageView sizeToFit];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.imageView];
}

@end
