//
//  ViewController.m
//  Dropit
//
//  Created by Davis Koh on 12/27/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "DropitViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"

@interface DropitViewController () <UIDynamicAnimatorDelegate>

@property (strong, nonatomic) BezierPathView *gameView;

@property (strong, nonatomic) UIDynamicAnimator *animator;

@property (strong, nonatomic) DropitBehavior *dropitBehavior;

@property (strong, nonatomic) UIAttachmentBehavior *attachmentBehavior;
// used to keep track of which view is currently dropping
@property (strong, nonatomic) UIView *droppingView;

@end

@implementation DropitViewController

- (UIDynamicAnimator *)animator {
    if (!_animator) _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
    return _animator;
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    [self removeCompletedRows];
}

- (void)animateRemovingDrops:(NSArray *)dropsToRemove {
    [UIView animateWithDuration:1.0
                     animations:^{
                         for (UIView *drop in dropsToRemove) {
                             CGFloat width = self.gameView.bounds.size.width;
                             int x = (arc4random()%(int)(width * 5)) - (int)width * 2;
                             int y = self.gameView.bounds.size.height;
                             drop.center = CGPointMake(x, -y);
                         }
                     }
                     completion:^(BOOL finished) {
                         // remove obj from super view
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
}

- (BOOL)removeCompletedRows {
    // TODO: figure out which drops to remove
    NSMutableArray *dropsToRemove = @[].mutableCopy;

    if ([dropsToRemove count]) {
        for (UIView *drop in dropsToRemove) {
            [self.dropitBehavior removeItem:drop];
        }
        [self animateRemovingDrops:dropsToRemove];
    }

    return NO;
}

- (DropitBehavior *)dropitBehavior {
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}

static const CGSize DROP_SIZE = { 40, 40 };

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.gameView = [[BezierPathView alloc] initWithFrame:self.view.frame];
    self.gameView.backgroundColor = [UIColor whiteColor];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tap:)];
    [self.gameView addGestureRecognizer:tapGesture];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(pan:)];
    [self.gameView addGestureRecognizer:panGesture];


    [self.view addSubview:self.gameView];
}

- (void)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

// TODO: rename to grab drop (action not really panning)
- (void)pan:(UIPanGestureRecognizer *)sender {
    // where is pan pesture / where it happened
    CGPoint gesturePoint = [sender locationInView:self.gameView];

    if (sender.state == UIGestureRecognizerStateBegan) {
        [self attachDroppingViewToPoint:gesturePoint];
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        self.attachmentBehavior.anchorPoint = gesturePoint;
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        // stop doing animation
        [self.animator removeBehavior:self.attachmentBehavior];

        // otherwise line will remain in view
        self.gameView.path = nil;
    }
}

- (void)attachDroppingViewToPoint:(CGPoint)anchorPoint {
    if (self.droppingView) {
        self.attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.droppingView
                                                            attachedToAnchor:anchorPoint];

        // NOTE: how self.droppingView is set to nil below block def
        // thus, need to have ref when self.droppingView is defined
        UIView *droppingView = self.droppingView;

        // everytime animation run, block below is executed
        // [[update "that thing" lol what fucking "thing"?]]
        __weak DropitViewController *weakSelf = self;
        self.attachmentBehavior.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachmentBehavior.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };

        // dont allow grabbing of drop again
        self.droppingView = nil;

        // as soon as below is executed, animator will begin animating the behavior
        [self.animator addBehavior:self.attachmentBehavior];
    }
}

- (void)drop {
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;

    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];

    self.droppingView = dropView;
    [self.dropitBehavior addItem:dropView];
}

- (UIColor *)randomColor {
    switch (arc4random()%5) {
        case 0: return [UIColor greenColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor redColor];
        case 4: return [UIColor purpleColor];
    }
    return [UIColor blackColor];
}

@end
