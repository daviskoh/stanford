//
//  JustPostedFlickrPhotosTableViewController.m
//  Shutterbug
//
//  Created by Davis Koh on 1/2/16.
//  Copyright © 2016 com.DavisKoh. All rights reserved.
//

#import "JustPostedFlickrPhotosTableViewController.h"
#import "FlickrFetcher.h"

@interface JustPostedFlickrPhotosTableViewController ()

@end

@implementation JustPostedFlickrPhotosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self fetchPhotos];
}

- (void)fetchPhotos {
    self.photos = nil;
}

@end
