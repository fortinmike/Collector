//
//  NSArray+SortingSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-13.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSArray+Sorting.h"


SPEC_BEGIN(NSArray_SortingSpec)

describe(@"NSArray+Sorting", ^
{
	context(@"reversed", ^
	{
		it(@"should return an array with all objects in reverse order", ^
		{
			NSArray *strings = @[@"A", @"B", @"C"];
			
			[[[strings reversed] should] equal:@[@"C", @"B", @"A"]];
		});
	});
	
	context(@"shuffled", ^
	{
		it(@"should contain all of the receiver's objects", ^
		{
			NSArray *strings = @[@"A", @"B", @"C", @1, @2];
			
			NSArray *shuffled = [strings shuffled];
			
			[[shuffled should] containObjects:@"A", @"B", @"C", @1, @2, nil];
		});
	});
	
	context(@"ordered by ascending", ^
	{
		it(@"should order numbers properly", ^
		{
			NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
			NSArray *expectedOrder = @[@(-1), @1, @1, @3, @3.2, @5, @10, @22, @55];
			NSArray *ordered = [numbers orderedByAscending:^id(id object) { return object; }];
			
			[[ordered should] equal:expectedOrder];
		});
		
		it(@"should order strings in logical order", ^
		{
			NSArray *strings = @[@"A", @"B", @"2", @"1", @"22", @"Z", @"11"];
			NSArray *expectedOrder = @[@"1", @"2", @"11", @"22", @"A", @"B", @"Z"];
			NSArray *ordered = [strings orderedByAscending:^id(id object) { return object; }];
			
			[[ordered should] equal:expectedOrder];
		});
	});
	
	context(@"ordered by descending", ^
	{
		it(@"should order numbers properly", ^
		{
			NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
			NSArray *expectedOrder = @[@55, @22, @10, @5, @3.2, @3, @1, @1, @(-1)];
			NSArray *ordered = [numbers orderedByDescending:^id(id object) { return object; }];
			
			[[ordered should] equal:expectedOrder];
		});
		
		it(@"should order strings in logical order", ^
		{
			NSArray *strings = @[@"A", @"B", @"2", @"1", @"22", @"Z", @"11"];
			NSArray *expectedOrder = @[@"Z", @"B", @"A", @"22", @"11", @"2", @"1"];
			NSArray *ordered = [strings orderedByDescending:^id(id object) { return object; }];
			
			[[ordered should] equal:expectedOrder];
		});
	});
});



SPEC_END