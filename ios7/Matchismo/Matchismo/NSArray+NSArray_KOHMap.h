//
//  NSArray+NSArray_KOHMap.h
//  Matchismo
//
//  Created by Davis Koh on 12/15/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (NSArray_KOHMap)

- (NSArray *) map:(id(^)(id obj))block;

@end
