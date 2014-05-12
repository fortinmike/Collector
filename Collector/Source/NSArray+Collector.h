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

/**
 *  Eliminates duplicates from an array by comparing objects together using -isEqual:.
 *
 *  @return A new array containing only distinct objects (no duplicates).
 */
- (instancetype)distinct;

/**
 *  Eliminates duplicates from an array by comparing the return value of *valueBlock* instead of comparing objects directly.
 *  For example, given an array that contains Person objects and a *valueBlock* that returns a person's first name, the resulting
 *  array would contain only one Person object per distinct first name.
 *
 *  @param valueBlock A block that returns the value to use for comparison..
 *
 *  @return A new array containing only one object per distinct value returned from *valueBlock*.
 */
- (instancetype)distinct:(GatheringBlock)valueBlock;

/**
 *  Obtains a range of objects from the array.
 *
 *  @param range The range of objects to obtain.
 *
 *  @return A new array containing the objects for the given range in the receiver.
 */
- (instancetype)objectsInRange:(NSRange)range;

/**
 *  Returns all objects whose class is the same as the specified kind.
 *
 *  @param kind The class of objects to obtain from the receiver.
 *
 *  @return A new array containing all objects that are of the given kind.
 */
- (instancetype)objectsOfKind:(Class)kind;

/**
 *  Returns a single value by applying the block to all of the receiver's objects in sequence and cumulating the results.
 *  The *cumulated* block parameter is nil for the first block invocation.
 *
 *  @param reducingBlock A block that returns the cumulated value at each iteration.
 *  @param cumulated The last value that was returned from *reducingBlock*.
 *  @param object The current array object.
 *
 *  @return The cumulated value after invoking *reducingBlock* on each of the receiver's objects.
 */
- (id)reduce:(id(^)(id cumulated, id object))reducingBlock;

/**
 *  Same as -reduce: but with an initial seed value.
 */
- (id)reduceWithSeed:(id)seed block:(id(^)(id cumulated, id object))reducingBlock;

/**
 *  Iterates over each object and performs the given operation with each object as an argument.
 *  Equivalent to a *for each* but makes for a clean one-liner when iterating over array elements.
 *
 *  @param operation The operation to perform for each of the array's objects.
 */
- (void)each:(OperationBlock)operation;

/**
 *  Iterates over each object and performs the given operation with each object and the current index as arguments.
 *  Useful when you care both about the current object and that object's index in the array.
 *
 *  @param operation The operation to perform for each of the array's objects.
 */
- (void)eachWithIndex:(void(^)(id object, NSUInteger index))operation;

/**
 *  Compares all array objects using the given *comparisonBlock* and returns the final winner.
 *
 *  @param comparisonBlock The comparison operation to determine the winner between any two objects.
 *
 *  @return The object that wins the comparison against all other array objects.
 */
- (id)winner:(id(^)(id object1, id object2))comparisonBlock;

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