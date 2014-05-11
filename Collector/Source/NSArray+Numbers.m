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
	return [self compare:^id(NSNumber *num1, NSNumber *num2)
	{
		return (([num1 compare:num2] == NSOrderedAscending) ? num1 : num2);
	}];
}

- (NSNumber *)max
{
	return [self compare:^id(NSNumber *num1, NSNumber *num2)
	{
		return (([num1 compare:num2] == NSOrderedDescending) ? num1 : num2);
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