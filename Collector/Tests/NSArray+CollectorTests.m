//
//  NSArray+CollectorTests.m
//  Obsidian
//
//  Created by Michaël Fortin on 2012-12-22.
//  Copyright (c) 2012 irradiated.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+CollectorTests.h"
#import "NSArray+Collector.h"

@implementation NSArray_CollectorTests

#pragma mark Convenience Methods

- (NSArray *)disparateObjects
{
	return @[@8, @"Test", @9.3, @{@"Key": @"Value1"}, @{@"Special": @"Value2"}, @"Another string"];
}

- (NSArray *)numbers
{
	return @[@9.0, @10, @91, @12, @234];
}

- (NSArray *)strings
{
	return @[@"String1", @"String2", @"String3"];
}

#pragma mark Test Cases

- (void)testFirstOrDefault
{
	id object1 = [[self disparateObjects] first:^BOOL(id obj) { return [obj isKindOfClass:[NSString class]]; }  orDefault:@"Default"];
	XCTAssertEqualObjects(object1, @"Test", @"Returned object was not the first string");
	
	id object2 = [[self disparateObjects] first:^BOOL(id obj) { return [obj isKindOfClass:[NSDictionary class]]; }  orDefault:@"Default"];
	XCTAssertEqualObjects(object2, @{@"Key": @"Value1"}, @"Returned object was not the first dictionary");
	
	id object3 = [[self disparateObjects] first:^BOOL(id obj) { return [obj isKindOfClass:[NSFileManager class]]; } orDefault:@"Default"];
	XCTAssertEqualObjects(object3, @"Default", @"Returned object was not the default value");
}

- (void)testWhereSimple
{
	NSArray *results = [[self disparateObjects] where:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }];
	XCTAssertEqual((int)[results count], 2, @"The where method failed to return the right amount of numbers.");
}

- (void)testWhereComplex
{
	NSArray *results = [[self disparateObjects] where:^BOOL(id object) {
		BOOL isDictionary = [object isKindOfClass:[NSDictionary class]];
		if (isDictionary)
		{
			BOOL containsSpecialValue = ((NSDictionary *)object[@"Special"] != nil);
			if (containsSpecialValue) return YES;
		}
		return NO;
	}];
	XCTAssertEqual((int)[results count], 1, @"The where method failed to return the right amount of numbers.");
}

- (void)testMap
{
	NSArray *results = [[self disparateObjects] map:^id(id object) {
		// Return the first value of the dictionary if the object is a dictionary
		if ([object isKindOfClass:[NSDictionary class]])
			return [(NSDictionary *)object allValues][0];
		
		return nil;
	}];
	XCTAssertEqual((int)[results count], 2, @"The wrong number of values were returned!");
	XCTAssertEqualObjects(results[0], @"Value1", @"The returned value is wrong!");
	XCTAssertEqualObjects(results[1], @"Value2", @"The returned value is wrong!");
}

- (void)testMapDerivedObjects
{
	NSArray *mutableStrings = [self strings];
	NSArray *results = [mutableStrings map:^id(NSMutableString *string) {
		return @"Something derived from the original object";
	}];
	
	XCTAssertEqual([results count], [mutableStrings count], @"Object count changed");
	
	for (NSString *object in results)
		XCTAssertEqualObjects(object, @"Something derived from the original object", @"The each: method did not affect all objects!");
}

- (void)testReduce
{
	NSArray *stuff = @[@"A", @"B", @"C", @"D"];
	NSString *combined = [stuff reduce:^id(id cumulated, id object)
	{
		if (cumulated == nil) cumulated = @"";
		return [cumulated stringByAppendingString:object];
	}];
	
	XCTAssertEqualObjects(combined, @"ABCD");
}

- (void)testReduceWithSeed
{
	NSArray *stuff = @[@"A", @"B", @"C", @"D"];
	NSString *combined = [stuff reduceWithSeed:@"" block:^id(id cumulated, id object)
    {
		return [cumulated stringByAppendingString:object];
	}];
	
	XCTAssertEqualObjects(combined, @"ABCD");
}

- (void)testEach
{
	NSMutableArray *cumulated = [NSMutableArray array];
	[[self strings] each:^(NSMutableString *string) { [cumulated addObject:string]; }];
	
	XCTAssertEqualObjects(cumulated, [self strings]);
}

- (void)testAll
{
	NSArray *disparateObjects = [self disparateObjects];
	NSArray *numbers = [self numbers];
	
	XCTAssertFalse([disparateObjects all:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }]);
	XCTAssertTrue([numbers all:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }]);
}

- (void)testEachWithIndex
{
	NSArray *expectedIndexes = @[@0, @1, @2];
	
	NSMutableArray *objects = [NSMutableArray array];
	NSMutableArray *indexes = [NSMutableArray array];
	
	[[self strings] eachWithIndex:^(NSMutableString *string, NSUInteger index)
	{
		[objects addObject:string];
		[indexes addObject:@(index)];
	}];
	
	XCTAssertEqualObjects(objects, [self strings]);
	XCTAssertEqualObjects(indexes, expectedIndexes);
}

- (void)testOrderByAscendingNumbers
{
	NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
	NSArray *expectedOrder = @[@(-1), @1, @1, @3, @3.2, @5, @10, @22, @55];
	NSArray *ordered = [numbers orderedByAscending:^id(id object) { return object; }];
	XCTAssertTrue([ordered isEqual:expectedOrder], @"Objects were not in the expected order");
}

- (void)testOrderByDescendingNumbers
{
	NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
	NSArray *expectedOrder = @[@55, @22, @10, @5, @3.2, @3, @1, @1, @(-1)];
	NSArray *ordered = [numbers orderedByDescending:^id(id object) { return object; }];
	XCTAssertTrue([ordered isEqual:expectedOrder], @"Objects were not in the expected order");
}

- (void)testOrderByAscendingStrings
{
	NSArray *strings = @[@"BCD", @"ABC", @"DBA"];
	NSArray *expectedOrder = @[@"ABC", @"BCD", @"DBA"];
	NSArray *ordered = [strings orderedByAscending:^id(id object) { return object; }];
	XCTAssertTrue([ordered isEqual:expectedOrder], @"Objects were not in the expected order");
}

- (void)testOrderByDescendingStrings
{
	NSArray *strings = @[@"BCD", @"ABC", @"DBA"];
	NSArray *expectedOrder = @[@"DBA", @"BCD", @"ABC"];
	NSArray *ordered = [strings orderedByDescending:^id(id object) { return object; }];
	XCTAssertTrue([ordered isEqual:expectedOrder], @"Objects were not in the expected order");
}

- (void)testOrderByAscendingStringsLogical
{
	NSArray *strings = @[@"A", @"2", @"1", @"22", @"Z", @"11"];
	NSArray *expectedOrder = @[@"1", @"2", @"11", @"22", @"A", @"Z"];
	NSArray *ordered = [strings orderedByAscending:^id(id object) { return object; }];
	XCTAssertTrue([ordered isEqual:expectedOrder], @"Objects were not in the expected order");
}

@end