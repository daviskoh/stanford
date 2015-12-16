//
//  NSArray+NSArray_KOHMap.m
//  Matchismo
//
//  Created by Davis Koh on 12/15/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import "NSArray+NSArray_KOHMap.h"

@implementation NSArray (NSArray_KOHMap)

- (NSArray *) map:(id(^)(id obj))block {
    NSMutableArray *result = @[].mutableCopy;

    for (id o in self) {
        [result addObject:block(o)];
    }

    return result;
}

@end
