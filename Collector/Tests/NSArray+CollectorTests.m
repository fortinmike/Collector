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
#import "NSArray+Sorting.h"

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

- (void)testAll
{
	NSArray *disparateObjects = [self disparateObjects];
	NSArray *numbers = [self numbers];
	
	XCTAssertFalse([disparateObjects all:^BOOL(id object) { return [object isKindOfClass:[NSString class]]; }]);
	XCTAssertTrue([numbers all:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }]);
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