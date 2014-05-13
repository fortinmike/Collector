//
//  NSArray+CollectorSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSArray+Collector.h"


SPEC_BEGIN(NSArray_CollectorSpec)

describe(@"NSArray+Collector", ^
{
	context(@"first with condition", ^
	{
		it(@"should return the first matching object if there are objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo", @2, @"Bar"];
			[[[objects first:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }] should] equal:@"Foo"];
		});
		
		it(@"should return nil if there are no objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo"];
			[[[objects first:^BOOL(id object) { return [object isKindOfClass:[NSData class]]; }] should] beNil];
		});
	});
	
	context(@"first or default", ^
	{
		it(@"should return the first matching object if there are objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo", @2, @"Bar"];
			[[[objects first:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; } orDefault:@"Default"] should] equal:@"Foo"];
		});
		
		it(@"should return the default value if there are no objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo"];
			[[[objects first:^BOOL(id object) { return [object isKindOfClass:[NSData class]]; } orDefault:@"Default"] should] equal:@"Default"];
		});
	});
	
	context(@"last with condition", ^
	{
		it(@"should return the last matching object if there are objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo", @2, @"Bar", @3];
			[[[objects last:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }] should] equal:@"Bar"];
		});
		
		it(@"should return nil if there are no objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo"];
			[[[objects last:^BOOL(id object) { return [object isKindOfClass:[NSData class]]; }] should] beNil];
		});
	});
	
	context(@"last or default", ^
	{
		it(@"should return the last matching object if there are objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo", @2, @"Bar"];
			[[[objects last:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; } orDefault:@"Default"] should] equal:@2];
		});
		
		it(@"should return the default value if there are no objects matching the condition in the array", ^
		{
			NSArray *objects = @[@1, @"Foo"];
			[[[objects last:^BOOL(id object) { return [object isKindOfClass:[NSData class]]; } orDefault:@"Default"] should] equal:@"Default"];
		});
	});
	
	context(@"where", ^
	{
		it(@"should return all objects that match the given condition", ^
		{
			NSArray *objects = @[@1, @2, @"Three", @4];
			NSArray *expectedObjects = @[@1, @2, @4];
			[[[objects where:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }] should] equal:expectedObjects];
		});
	});
	
	context(@"map", ^
	{
		it(@"should return an array containing objects returned from the gathering block", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];
			NSArray *expectedObjects = @[@"A-hello", @"B-hello", @"C-hello"];
			
			NSArray *resultingObjects = [objects map:^id(NSString *string)
			{
				return [string stringByAppendingString:@"-hello"];
			}];
			
			[[resultingObjects should] equal:expectedObjects];
		});
		
		it(@"should return fewer elements when nil is returned from the gathering block", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];
			NSArray *expectedObjects = @[@"A-hello", @"C-hello"];
			
			NSArray *resultingObjects = [objects map:^id(NSString *string)
			{
				if ([string isEqualToString:@"B"]) return nil;
				return [string stringByAppendingString:@"-hello"];
			}];
			
			[[resultingObjects should] equal:expectedObjects];
		});
	});
	
	context(@"reduce", ^
	{
		it(@"should return a value as cumulated by each iteration with the first cumulated value being the first object in the array", ^
		{
			NSArray *strings = @[@"A", @"B", @"C", @"D"];
			
			NSString *combined = [strings reduce:^id(id cumulated, id object)
			{
				return [cumulated stringByAppendingString:object];
			}];
			
			[[combined should] equal:@"ABCD"];
		});
	});
	
	context(@"reduce with seed", ^
	{
		it(@"should return a cumulated value with the given seed as a starting point", ^
		{
			NSArray *strings = @[@"A", @"B", @"C", @"D", @"!"];
			
			NSString *combined = [strings reduceWithSeed:@"Hello " block:^id(id cumulated, id object)
			{
				return [cumulated stringByAppendingString:object];
			}];
			
			[[combined should] equal:@"Hello ABCD!"];
		});
	});
	
	context(@"each", ^
	{
		it(@"should iterate over all array elements", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];
			
			NSMutableArray *cumulated = [NSMutableArray array];
			[objects each:^(NSMutableString *string) { [cumulated addObject:string]; }];
			
			[[cumulated should] equal:objects];
		});
	});
	
	context(@"each with index", ^
	{
		it(@"should iterate over all array elements with the proper index", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];
			NSArray *expectedIndexes = @[@0, @1, @2];
			
			NSMutableArray *cumulated = [NSMutableArray array];
			NSMutableArray *indexes = [NSMutableArray array];
			
			[objects eachWithIndex:^(NSMutableString *string, NSUInteger index)
			{
				[cumulated addObject:string];
				[indexes addObject:@(index)];
			}];
			
			[[cumulated should] equal:objects];
			[[indexes should] equal:expectedIndexes];
		});
	});
	
	context(@"except", ^
	{
		NSArray *strings = @[@"A", @"B", @"C"];
		
		NSArray *filtered = [strings except:^BOOL(NSString *string) { return [string isEqualToString:@"A"]; }];
		
		[[filtered shouldNot] contain:@"A"];
		[[theValue([filtered count]) should] equal:theValue(2)];
	});
	
	context(@"take", ^
	{
		it(@"should return no object when asked for zero objects", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];

			NSArray *taken = [objects take:0];
			
			[[taken should] beKindOfClass:[NSArray class]];
			[[theValue([taken count]) should] equal:theValue(0)];
		});
		
		it(@"should return the maximum amount of objects when there are enough items in the array", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];
			
			NSArray *taken = [objects take:2];
			
			[[taken should] equal:@[@"A", @"B"]];
		});
		
		it(@"should return less objects when there are not enough objects in the array", ^
		{
			NSArray *objects = @[@"A", @"B", @"C"];
			
			NSArray *taken = [objects take:15];
			
			[[taken should] equal:@[@"A", @"B", @"C"]];
		});
	});
	
	context(@"distinct", ^
	{
		it(@"should keep only once instance for equal objects", ^
		{
			NSArray *objects = @[@"A", @"A", @"B", @"C", @"C"];
			
			[[[objects distinct] should] equal:@[@"A", @"B", @"C"]];
		});
		
		it(@"should keep only one instance given the same instance multiple times", ^
		{
			NSString *instance = @"B";
			NSArray *objects = @[@"A", instance, @"C", instance];
			
			[[[objects distinct] should] equal:@[@"A", @"B", @"C"]];
		});
	});
	
	context(@"distinct with value block", ^
	{
		
	});
	
	context(@"objects in range", ^
	{
		
	});
	
	context(@"objects of kind", ^
	{
		
	});
	
	context(@"winner", ^
	{
		
	});
	
	context(@"all", ^
	{
		
	});
	
	context(@"any", ^
	{
		
	});
	
	context(@"none", ^
	{
		
	});
	
	context(@"count with block", ^
	{
		
	});
});

SPEC_END