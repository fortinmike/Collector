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

/**
 *  Assuming that the array contains only NSNumber instances, returns the NSNumber
 *  instance with the lowest value.
 *
 *  @return The lowest NSNumber in the array.
 */
- (NSNumber *)min;

/**
 *  Making no assumption about array contents, this method provides a block from which an
 *  NSNumber must be returned. The object that is returned from -min: is the object for
 *  which *numberBlock* returns the lowest value.
 *
 *  @return the object where *numberBlock* returns the lowest value.
 */
- (NSNumber *)min:(NumberBlock)numberBlock;

/**
 *  Assuming that the array contains only NSNumber instances, returns the NSNumber
 *  instance with the highest value.
 *
 *  @return The highest NSNumber in the array.
 */
- (NSNumber *)max;

/**
 *  Making no assumption about array contents, this method provides a block from which an
 *  NSNumber must be returned. The object that is returned from -max: is the object for
 *  which *numberBlock* returns the highest value.
 *
 *  @return the object where *numberBlock* returns the highest value.
 */
- (NSNumber *)max:(NumberBlock)numberBlock;

/**
 *  Assuming the array contains only NSNumber instances, returns a new NSNumber whose value
 *  is the sum of all NSNumber instances in the array.
 *
 *  @return The sum of all NSNumber instances in the array.
 */
- (NSNumber *)sum;

@end