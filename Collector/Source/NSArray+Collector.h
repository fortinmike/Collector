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

- (id)first; // Returns the first object in the array or nil if the array is empty
- (id)first:(ConditionBlock)condition; // Returns the first object that matches or nil
- (id)first:(ConditionBlock)condition orDefault:(id)defaultObject; // Returns the first object that matches or a default value
- (id)last; // Returns the last object in the array or nil if the array is empty
- (id)last:(ConditionBlock)condition; // Returns the last object that matches the condition, or nil if none is found
- (id)last:(ConditionBlock)condition orDefault:(id)defaultObject; // Returns the last object that matches the condition or the specified default value
- (instancetype)where:(ConditionBlock)condition; // Returns objects that match the specified condition
- (instancetype)except:(ConditionBlock)condition; // Returns all objects but those that match the specified condition
- (instancetype)take:(NSUInteger)count; // Returns the first [count] objects of the array or fewer objects if the array is smaller than the specified count
- (instancetype)map:(GatheringBlock)gatheringBlock; // Returns objects gathered or computed from the array's objects as returned from the gathering block
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