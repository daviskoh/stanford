//
//  FlickerPhotosTableViewController.m
//  Shutterbug
//
//  Created by Davis Koh on 1/2/16.
//  Copyright © 2016 com.DavisKoh. All rights reserved.
//

#import "FlickrPhotosTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface FlickrPhotosTableViewController ()

@property (strong, nonatomic) ImageViewController *imageViewCtrl;

@end

@implementation FlickrPhotosTableViewController

- (ImageViewController *)imageViewCtrl {
    if (!_imageViewCtrl) _imageViewCtrl = [[ImageViewController alloc] init];
    return _imageViewCtrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPhotos:(NSArray *)photos {
    _photos = photos;
    // when model changes, update views
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

static NSString *cellTitle = @"FlickrTableViewCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTitle];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellTitle];
    }

    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = [photo valueForKey:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];

    return cell;
}

- (void)prepareImageViewController:(ImageViewController *)ivc
                    toDisplayPhoto:(NSDictionary *)photo {

    ivc.imageURL = [FlickrFetcher URLforPhoto:photo
                                      format:FlickrPhotoFormatLarge];
    ivc.title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self prepareImageViewController:self.imageViewCtrl
                      toDisplayPhoto:self.photos[indexPath.row]];

    // check if detail view is visible
    if (self.splitViewController.viewControllers.count > 1) {
        NSArray *viewCtrls = @[self.navigationController, self.imageViewCtrl];
        self.navigationController.splitViewController.viewControllers = viewCtrls;
    } else {
        [self.navigationController pushViewController:self.imageViewCtrl
                                         animated:YES];
    }
}

@end
