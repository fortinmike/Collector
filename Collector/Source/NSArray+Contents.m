//
//  NSArray+Contents.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import "NSArray+Contents.h"
#import "NSArray+Collector.h"

@implementation NSArray (Contents)

#pragma mark Array Contents Checking

- (BOOL)containsObjects:(NSArray *)array
{
	for (id object in array)
		if (![self containsObject:object]) return NO;
	
	return YES;
}

- (BOOL)containsOnlyObjects:(NSArray *)array
{
	NSUInteger count1 = [self count];
	NSUInteger count2 = [array count];
	
	if (count1 != count2) return NO;
	
	return [self containsObjects:array];
}

- (BOOL)containsAnyObject:(NSArray *)objects
{
	return [objects any:^BOOL(id object) { return [self containsObject:object]; }];
}

- (BOOL)areObjectsKindOfClass:(Class)klass
{
	return [self all:^BOOL(id object) { return [object isKindOfClass:klass]; }];
}

@end