//
//  SetCard.m
//  Matchismo
//
//  Created by Davis Koh on 12/12/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// TODO: override contents to include color/shading

+ (NSArray *)validSuits {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)rankStrings {
    return @[@"1", @"2", @"3"];
}

// TODO: override match: to include color/shading

@end
