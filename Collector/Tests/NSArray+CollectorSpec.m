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
		it(@"should keep only one instance for equal objects", ^
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
		it(@"should keep only one instace for each distinct value returned by the value block", ^
		{
			NSArray *objects = @[@"A", @"A", @1, @"C", @2];
			
			NSArray *distinctObjects = [objects distinct:^id(id object) { return [object class]; }];
			
			[[distinctObjects should] equal:@[@"A", @1]];
		});
	});
	
	context(@"objects in range", ^
	{
		it(@"should return the correct objects", ^
		{
			NSArray *objects = @[@1, @2, @3, @4];
			
			NSArray *obtained = [objects objectsInRange:NSMakeRange(1, 2)];
			
			[[obtained should] equal:@[@2, @3]];
		});
		
		it(@"should throw if the range exceeds the array's bounds", ^
		{
			NSArray *objects = @[@1, @2, @3, @4];
			
			[[theBlock(^{ [objects objectsInRange:NSMakeRange(1, 30)]; }) should] raise];
		});
	});
	
	context(@"objects of kind", ^
	{
		it(@"should return only objects of the specified kind", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			NSArray *strings = [objects objectsOfKind:[NSString class]];
			NSArray *numbers = [objects objectsOfKind:[NSNumber class]];
			
			[[strings should] equal:@[@"A", @"B", @"C"]];
			[[numbers should] equal:@[@1, @2, @3, @4]];
		});
	});
	
	context(@"winner", ^
	{
		it(@"should return the winner when there is a single object that can win according to the condition", ^
		{
			NSArray *objects = @[@1, @4, @2, @3];
			
			NSNumber *winner = [objects winner:^NSNumber *(NSNumber *nb1, NSNumber *nb2)
			{
				return [nb1 compare:nb2] == NSOrderedAscending ? nb2 : nb1;
			}];
			
			[[winner should] equal:@4];
		});
		
		it(@"should return an object when multiple objects could win", ^
		{
			NSArray *objects = @[@1, @4, @4, @3];
			
			NSNumber *winner = [objects winner:^NSNumber *(NSNumber *nb1, NSNumber *nb2)
			{
				return [nb1 compare:nb2] == NSOrderedAscending ? nb2 : nb1;
			}];
			
			[[winner should] equal:@4];
		});
	});
	
	context(@"all", ^
	{
		it(@"should return YES when all objects match the condition", ^
		{
			NSArray *objects = @[@0, @1, @2, @3, @4];
			
			BOOL allObjectsAreNumbers = [objects all:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }];
			
			[[theValue(allObjectsAreNumbers) should] beYes];
		});
		
		it(@"should return NO when one or more objects don't match the condition", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			BOOL allObjectsAreStrings = [objects all:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }];
			
			[[theValue(allObjectsAreStrings) should] beNo];
		});
	});
	
	context(@"any", ^
	{
		it(@"should return YES when at least one object matches the condition", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			BOOL anyObjectIsAString = [objects any:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }];
			
			[[theValue(anyObjectIsAString) should] beYes];
		});
		
		it(@"should return NO when no object matches the condition", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			BOOL anyObjectIsData = [objects any:^BOOL(id object) { return [object isKindOfClass:[NSData class]]; }];
			
			[[theValue(anyObjectIsData) should] beNo];
		});
	});
	
	context(@"none", ^
	{
		it(@"should return YES when no object matches the condition", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			BOOL anyObjectIsData = [objects none:^BOOL(id object) { return [object isKindOfClass:[NSData class]]; }];
			
			[[theValue(anyObjectIsData) should] beYes];
		});
		
		it(@"should return NO when at least one object matches the condition", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			BOOL anyObjectIsAString = [objects none:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }];
			
			[[theValue(anyObjectIsAString) should] beNo];
		});
	});
	
	context(@"count with block", ^
	{
		it(@"should return the number of objects that match the given condition", ^
		{
			NSArray *objects = @[@"A", @1, @2, @"B", @3, @4, @"C"];
			
			NSUInteger numberOfStrings = [objects count:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }];
			NSUInteger numberOfNumbers = [objects count:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }];
			
			[[theValue(numberOfStrings) should] equal:theValue(3)];
			[[theValue(numberOfNumbers) should] equal:theValue(4)];
		});
	});
});

SPEC_END