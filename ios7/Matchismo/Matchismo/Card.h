//
//  Card.h
//  Matchismo
//
//  Created by Davis Koh on 12/2/15.
//  Copyright © 2015 com.DavisKoh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

// NOTE: only time to explicitly change getter names
// is for BOOL properties
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
