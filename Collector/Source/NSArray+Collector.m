//
//  NSArray+Collector.m
//  Collector
//
//  Created by Michaël Fortin on 12-07-09.
//  Copyright (c) 2012 irradiated.net. All rights reserved.
//

#import "NSArray+Collector.h"

@implementation NSArray (Collector)

#pragma mark Creating Other Instances

- (instancetype)arrayByRemovingObject:(id)object
{
	return [self arrayByRemovingObjectsFromArray:@[object]];
}

- (instancetype)arrayByRemovingObjectsFromArray:(NSArray *)array
{
	NSMutableArray *newArray = [self mutableCopy];
	[newArray removeObjectsInArray:array];
	return [[self class] arrayWithArray:newArray];
}

#pragma mark Block-based Array Manipulation and Filtering

- (id)first:(ConditionBlock)condition
{
	for (id object in self)
		if (condition(object)) return object;
	
	return nil;
}

- (id)first:(ConditionBlock)condition orDefault:(id)defaultObject
{
	return [self first:condition] ?: defaultObject;
}

- (id)last:(ConditionBlock)condition
{
	return [[[self reverseObjectEnumerator] allObjects] first:condition];
}

- (id)last:(ConditionBlock)condition orDefault:(id)defaultObject
{
	return [self last:condition] ?: defaultObject;
}

- (instancetype)where:(ConditionBlock)condition
{
	NSMutableArray *selectedObjects = [NSMutableArray array];
	
	for (id obj in self)
	{
		if (condition(obj))
			[selectedObjects addObject:obj];
	}
	
	return selectedObjects;
}

- (instancetype)map:(ValueBlock)valueBlock
{
	NSMutableArray *values = [NSMutableArray array];
	
	for (id obj in self)
	{
		id value = valueBlock(obj);
		if (value != nil) [values addObject:value];
	}
	
	return values;
}

- (id)reduce:(id(^)(id cumulated, id object))reducingBlock
{
	id result = [self firstObject];
	
	for (int i = 1; i < [self count]; i++)
		result = reducingBlock(result, self[i]);
	
	return result;
}

- (id)reduceWithSeed:(id)seed block:(id(^)(id cumulated, id object))reducingBlock
{
	id result = seed;
	
	for (id obj in self)
		result = reducingBlock(result, obj);
	
	return result;
}

- (void)each:(OperationBlock)operation
{
	for (id obj in self)
		operation(obj);
}

- (void)eachWithIndex:(void(^)(id object, NSUInteger index))operation
{
	[self enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL *stop)
	{
		operation(object, index);
	}];
}

- (instancetype)except:(ConditionBlock)condition
{
	return [self where:^BOOL(id object){ return !condition(object); }];
}

- (instancetype)take:(NSUInteger)amount
{
	return [[self objectsInRange:NSMakeRange(0, MIN(amount, [self count]))] mutableCopy];
}

- (instancetype)distinct
{
	NSMutableArray *distinct = [NSMutableArray array];
	
	for (id object in self)
	{
		if ([distinct indexOfObject:object] == NSNotFound)
			[distinct addObject:object];
	}
	
	return distinct;
}

- (instancetype)distinct:(ValueBlock)valueBlock
{
	return [self reduceWithSeed:[NSMutableArray array] block:^id(NSMutableArray *cumulated, id object)
	{
		id value = valueBlock(object);
		BOOL objectAlreadyInArray = [cumulated any:^(id tested) { return [valueBlock(tested) isEqual:value]; }];
		if (!objectAlreadyInArray) [cumulated addObject:object];
		return cumulated;
	}];
}

- (instancetype)objectsInRange:(NSRange)range
{
	return [[self objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:range]] mutableCopy];
}

- (instancetype)objectsOfKind:(Class)kind
{
	return [self where:^BOOL(id object) { return [object isKindOfClass:kind]; }];
}

- (id)winner:(id(^)(id object1, id object2))comparisonBlock
{
	if ([self count] == 0) return nil;
	if ([self count] == 1) return self[0];
	
	__block id winner = self[0];
	
	for (id contestant in self)
		winner = comparisonBlock(winner, contestant);
	
	return winner;
}

- (BOOL)all:(ConditionBlock)testBlock
{
	BOOL success = YES;
	
	for (id object in self)
		success &= testBlock(object);
	
	return success;
}

- (BOOL)any:(ConditionBlock)testBlock
{
	for (id object in self)
		if (testBlock(object)) return YES;
	
	return NO;
}

- (BOOL)none:(ConditionBlock)testBlock
{
	BOOL success = YES;
	
	for (id object in self)
		success &= !testBlock(object);
	
	return success;
}

- (NSUInteger)count:(ConditionBlock)testBlock
{
	NSUInteger count = 0;
	
	for (id object in self)
		count += testBlock(object);
	
	return count;
}

@end