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

// nil - object pointer
// NULL - C pointer

- (void)fetchPhotos {
    NSURL *url = [FlickrFetcher URLforRecentGeoreferencedPhotos];
# warning Blocking Main Thread
    NSData *jsonResults = [NSData dataWithContentsOfURL:url];
    NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                        options:0
                                                                          error:NULL];

    NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
    self.photos = photos;
}

@end
