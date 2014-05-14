//
//  NSArray+Numbers.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import "NSArray+Numbers.h"
#import "NSArray+Collector.h"

@implementation NSArray (Numbers)

#pragma mark Manipulating Arrays of NSNumber Instances

- (NSNumber *)min
{
	return [self min:^id(NSNumber *number) { return number; }];
}

- (NSNumber *)max
{
	return [self max:^id(NSNumber *number) { return number; }];
}

- (NSNumber *)min:(NumberBlock)numberBlock
{
	return [self winner:^id(id obj1, id obj2)
	{
		return (([numberBlock(obj1) compare:numberBlock(obj2)] == NSOrderedAscending) ? obj1 : obj2);
	}];
}

- (NSNumber *)max:(NumberBlock)numberBlock
{
	return [self winner:^id(id obj1, id obj2)
	{
		return (([numberBlock(obj1) compare:numberBlock(obj2)] == NSOrderedDescending) ? obj1 : obj2);
	}];
}

- (NSNumber *)sum
{
	return [self reduceWithSeed:@(0) block:^id(NSNumber *cumulated, NSNumber *number)
	{
		return @([cumulated doubleValue] + [number doubleValue]);
	}];
}

@end