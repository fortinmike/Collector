//
//  NSArray+Numbers.h
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectorBlockTypes.h"

@interface NSArray (Numbers)

#pragma mark Manipulating Arrays of NSNumber Instances

- (NSNumber *)min;
- (NSNumber *)min:(NumberBlock)numberBlock;
- (NSNumber *)max;
- (NSNumber *)max:(NumberBlock)numberBlock;
- (NSNumber *)sum;

@end