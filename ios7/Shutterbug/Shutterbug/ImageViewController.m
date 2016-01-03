//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Davis Koh on 12/29/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController

- (UIActivityIndicatorView *)spinner {
    if (!_spinner) {
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _spinner;
}

- (void)positionSpinner:(UIActivityIndicatorView *)spinner {
    NSLayoutConstraint *xConstraint = [NSLayoutConstraint constraintWithItem:spinner
                                                                   attribute:NSLayoutAttributeCenterX
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterX
                                                                  multiplier:1
                                                                    constant:0];

    NSLayoutConstraint *yConstraint = [NSLayoutConstraint constraintWithItem:spinner
                                                                   attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual
                                                                      toItem:self.view
                                                                   attribute:NSLayoutAttributeCenterY
                                                                  multiplier:1
                                                                    constant:0];

    [self.view addConstraints:@[xConstraint, yConstraint]];
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];

        // NOTE: below is needed here (as well as setImage:) because
        // in setImage:, self.scrollView could potentially be nil
        // due to view ctrl life cycle order

        // NOTE: in class, prof does this in setter
        // must do it here because using lazy instantiaion to init NOT storyboard
        _scrollView.contentSize = self.image ? self.image.size : CGSizeZero;

        _scrollView.minimumZoomScale = 0.2;
        _scrollView.maximumZoomScale = 2.0;

        _scrollView.delegate = self;
    }
    return _scrollView;
}

// which of our views do we want to zoom
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)setImageURL:(NSURL *)imageURL {
    _imageURL = imageURL;
    [self startDownloadingImage];
}

- (void)startDownloadingImage {
    // clear out previous image
    self.image = nil;

    // TODO: difficult to see perf improvement on sluggish simulator so check some other way
    if (self.imageURL) {
        [self.view addSubview:self.spinner];
        self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
        [self positionSpinner:self.spinner];
        [self.spinner startAnimating];

        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        // OPTIMIZE: check if download is NOT currently happening for imageURL before executing fresh download
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                        completionHandler:^(NSURL * _Nullable localfile,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error) {
                                                            if (!error) {
                                                                // in case self.imageURL changed while request was executing
                                                                // ex: user taps image, changes mind, taps another image
                                                                if ([request.URL isEqual:self.imageURL]) {
                                                                    // NOTE: not allowed to use UIKit classes OFF MAIN QUEUE
                                                                    // UIImage is exception
                                                                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:localfile]];

                                                                    // UI-related code goes in main queue
                                                                    // can also do performSelectorOnMainThread:
                                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                                        self.image = image;
                                                                    });
                                                                }
                                                            }
                                                        }];
        // tasks start out suspended
        // need to explicitly start / resume it
        [task resume];
    }
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

    [self.spinner stopAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
}

@end
