//
//  NSArray+Collector.h
//  Collector
//
//  Created by Michaël Fortin on 12-07-09.
//  Copyright (c) 2012 irradiated.net. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OperationBlock)(id object);
typedef BOOL (^ConditionBlock)(id object);
typedef id (^GatheringBlock)(id object);

@interface NSArray (Collector)

#pragma mark Creating Other Instances

- (instancetype)arrayByRemovingObject:(id)object;
- (instancetype)arrayByRemovingObjectsFromArray:(NSArray *)array;

#pragma mark Block-based Array Manipulation and Filtering

/**
 *  Obtains the first object in the array. Equivalent to -firstObject.
 *
 *  @return The first object in the array, or nil if the array is empty.
 */
- (id)first;

/**
 *  Returns the first object that matches *condition* or nil if no object matches the condition.
 *
 *  @param condition A block that tests a single object for match.
 *
 *  @return The first object that matches the condition or nil if there is no match.
 */
- (id)first:(ConditionBlock)condition;

/**
 *  Returns the first object that matches *condition* or the specified default value.
 *
 *  @param condition     A block that tests a single object for match.
 *  @param defaultObject The object that gets returned if no object was found.
 */
- (id)first:(ConditionBlock)condition orDefault:(id)defaultObject;

/**
 *  Obtains the last object in the array. Equivalent to -lastObject.
 *
 *  @return The last object in the array, or nil if the array is empty.
 */
- (id)last;

/**
 *  Returns the last object that matches a condition.
 *
 *  @param condition A block that tests a single object for match.
 *
 *  @return The last object that matches the condition, or nil if there is no match.
 */
- (id)last:(ConditionBlock)condition;

/**
 *  Returns the last object that matches *condition* or the specified default value.
 *
 *  @param condition     A block that tests a single object for match.
 *  @param defaultObject The object that gets returned if no object was found.
 */
- (id)last:(ConditionBlock)condition orDefault:(id)defaultObject;

/**
 *  Selects items that match *condition*.
 *
 *  @param condition A block that tests a single object for match.
 *
 *  @return All objects that match the specified condition.
 */
- (instancetype)where:(ConditionBlock)condition;

/**
 *  Selects all objects but those that match the specified condition.
 *
 *  @param condition A block that tests a single object for match.
 *
 *  @return All objects that *don't* match the specified condition.
 */
- (instancetype)except:(ConditionBlock)condition;

/**
 *  Returns a given number of items from the array.
 *
 *  @param count The number of objects to take.
 *
 *  @return The first *[amount]* objects of the array or fewer objects if the array is smaller than the specified amount.
 */
- (instancetype)take:(NSUInteger)amount;

/**
 *  Creates a new array containing the objects returned from the gathering block.
 *
 *  @param gatheringBlock A block that extracts a value from each of the receiver's objects,
 *                        or creates entirely new objects constructed from those values.
 *
 *  @return An array containing all objects returned from invocations of the gathering block.
 */
- (instancetype)map:(GatheringBlock)gatheringBlock;


- (instancetype)distinct; // Returns a new collection where all duplicate objects have been eliminated
- (instancetype)distinct:(GatheringBlock)valueBlock; // Returns objects from the source collection, eliminating duplicates based on the given block
- (instancetype)objectsInRange:(NSRange)range; // Returns objects in the specified array range
- (instancetype)objectsOfKind:(Class)kind; // Returns all objects of the specified type
- (id)reduce:(id(^)(id cumulated, id object))reducingBlock; // Returns a single value by applying the block to all elements and accumulating the results
- (id)reduceWithSeed:(id)seed block:(id(^)(id cumulated, id object))reducingBlock; // Same as reduce: but with an initial "seed" value
- (instancetype)each:(OperationBlock)operation; // Iterates over each array item and returns the original array as a convenience
- (instancetype)eachWithIndex:(void(^)(id object, NSUInteger index))operation; // Iterates over each array item and exposes the current id through the block
- (id)compare:(id(^)(id object1, id object2))comparisonBlock; // Returns the object that wins the comparison against all other array objects
- (BOOL)all:(ConditionBlock)testBlock; // Tests each array object and returns YES only when all objects pass the test
- (BOOL)any:(ConditionBlock)testBlock; // Tests each array object and returns YES if at least one of the objects passes the test
- (BOOL)none:(ConditionBlock)testBlock; // Tests each array object and returns YES only if no object passes the test
- (NSUInteger)count:(ConditionBlock)testBlock; // Tests each array object and returns the number of objects that pass the test

#pragma mark Sorting / Ordering

- (instancetype)reversed; // Returns a copy of the array with its elements reversed
- (instancetype)shuffled; // Returns another array containing the same items as the receiver but in a random order
- (instancetype)orderedByAscending:(GatheringBlock)valueBlock; // Returns the array items in ascending order based on the value returned by the block
- (instancetype)orderedByDescending:(GatheringBlock)valueBlock; // Returns the array items in descending order based on the value returned by the block

@end