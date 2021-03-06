//
//  ViewController.m
//  Imaginarium
//
//  Created by Davis Koh on 12/29/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSDictionary *buttonURLs;

@end

@implementation ViewController

- (NSDictionary *)buttonURLs {
    if (!_buttonURLs) {
        // OPTIMIZE: remove hardcoding
        // OPTIMIZE: should this be a collection of image models?
        _buttonURLs = @{
                        @"Flower": @"photo_1",
                        @"Peppers": @"photo_2",
                        @"Jellyfish": @"photo_3"
                        };
    }
    return _buttonURLs;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat offset = -100;
    for (NSString *buttonTitle in self.buttonURLs) {
        UIButton *button = [[UIButton alloc] init];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button sizeToFit];

        CGRect frame = button.frame;
        frame.origin.x = CGRectGetMidX(self.view.bounds) - (button.frame.size.width / 2);
        frame.origin.y = CGRectGetMidY(self.view.bounds) + offset;
        offset += 100;
        button.frame = frame;

        [button addTarget:self
                   action:@selector(onButtonTap:)
         forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:button];
    }
}

- (void)onButtonTap:(UIButton *)sender {
    ImageViewController *imageViewCtrl = [[ImageViewController alloc] init];

    NSString *formattedString = [@[
                                  @"http:/",
                                  @"images.apple.com",
                                  @"v/iphone-5s",
                                  @"gallery",
                                  @"a/images",
                                  @"download",
                                  @"%@.jpg"
                                  ] componentsJoinedByString:@"/"];

    NSString *photoURLString = [NSString stringWithFormat:formattedString,
                                self.buttonURLs[sender.titleLabel.text]];

    imageViewCtrl.imageURL = [NSURL URLWithString:photoURLString];
    imageViewCtrl.title = photoURLString;

    [self.navigationController pushViewController:imageViewCtrl
                                         animated:YES];
}

@end
