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

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation ImageViewController

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

        // NOTE: below is needed here (as well as setImage:) because
        // in setImage:, self.scrollView could potentially be nil
        // due to view ctrl life cycle order

        // NOTE: in class, prof does this in setter
        // must do it here because using lazy instantiaion to init NOT storyboard
        _scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
    }
    return _scrollView;
}

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

    // can cause trouble if self.image == nil
    self.scrollView.contentSize = self.image ? self.image.size : CGSizeZero;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}

@end
