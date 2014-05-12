//
//  NSArray+ContentsSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSArray+Contents.h"


SPEC_BEGIN(NSArray_ContentsSpec)

//- (void)testContainsEqual
//{
//	XCTAssertTrue([[self disparateObjects] containsEqual:@8], @"Object in array but not found by containsEqual:!");
//	XCTAssertFalse([[self disparateObjects] containsEqual:@"NOT_IN_THE_ARRAY"], @"containsEqual: says that an object is in the array but it is not!");
//}
//
//- (void)testContainsEqualObjects
//{
//	NSArray *array1 = @[@"Object1", @"Object2", @"Object3"];
//	NSArray *array2 = @[@"Object3", @"Object1", @"Object2"];
//	NSArray *array3 = @[@"ObjectDifferent", @"Object1", @"Object2"];
//	NSArray *array4 = @[@"Object1", @"Object2", @"Object3", @"Object4"];
//	XCTAssertTrue([array1 containsEqualObjects:array2], @"Arrays contain equal objects but method returned NO");
//	XCTAssertFalse([array1 containsEqualObjects:array3], @"Arrays do not contain all equal objects");
//	XCTAssertFalse([array1 containsEqualObjects:array4], @"Receiver does not contain all objects from array");
//	XCTAssertTrue([array4 containsEqualObjects:array1], @"Receiver contains all objects from array");
//}
//
//- (void)testContainsOnlyEqualObjects
//{
//	NSArray *array1 = @[@"Object1", @"Object2", @"Object3"];
//	NSArray *array2 = @[@"Object3", @"Object1", @"Object2"];
//	NSArray *array3 = @[@"ObjectDifferent", @"Object1", @"Object2"];
//	NSArray *array4 = @[@"Object1", @"Object2", @"Object 3", @"Object4"];
//	XCTAssertTrue([array1 containsOnlyEqualObjects:array2], @"Arrays contain equal objects but method returned NO");
//	XCTAssertFalse([array1 containsOnlyEqualObjects:array3], @"Arrays do not contain all equal objects");
//	XCTAssertFalse([array1 containsOnlyEqualObjects:array4], @"Arrays do not contain the same number of objects so we shouldn't return YES");
//	XCTAssertFalse([array4 containsOnlyEqualObjects:array1], @"Arrays do not contain the same number of objects so we shouldn't return YES");
//}
//
//- (void)testAreObjectsKindOfClass
//{
//	XCTAssertFalse([[self disparateObjects] areObjectsKindOfClass:[NSNumber class]]);
//	XCTAssertTrue([[self numbersArray] areObjectsKindOfClass:[NSNumber class]]);
//	XCTAssertFalse([[self numbersArray] areObjectsKindOfClass:[NSString class]]);
//}

describe(@"NSArray+Contents", ^
{
	
});

SPEC_END