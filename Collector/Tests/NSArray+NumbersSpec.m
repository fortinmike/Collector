//
//  NSArray+NumbersSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSArray+Numbers.h"


SPEC_BEGIN(NSArray_NumbersSpec)

describe(@"NSArray+Numbers", ^
{
	context(@"min", ^
	{
		it(@"should return the instance of NSNumber with the lowest value in the array", ^
		{
			NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
			
			[[[numbers ct_min] should] equal:@(-1)];
		});
	});
	
	context(@"min with number block", ^
	{
		it(@"should return the object that has the lowest block-returned value in the array", ^
		{
			NSArray *numbers = @[@[@1], @[@5], @[@10], @[@3], @[@(-1)]];
			
			NSNumber *min = [numbers ct_min:^NSNumber *(id object) { return [object firstObject]; }];
			
			[[min should] equal:@[@(-1)]];
		});
	});
	
	context(@"max", ^
	{
		it(@"should return the instance of NSNumber with the highest value in the array", ^
		{
			NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
			
			[[[numbers ct_max] should] equal:@(55)];
		});
	});
	
	context(@"max with number block", ^
	{
		it(@"should return the object that has the highest block-returned value in the array", ^
		{
			NSArray *numbers = @[@[@1], @[@5], @[@10], @[@3], @[@(-1)]];
			
			NSNumber *min = [numbers ct_max:^NSNumber *(id object) { return [object firstObject]; }];
			
			[[min should] equal:@[@(10)]];
		});
	});
	
	context(@"sum", ^
	{
		it(@"should return the sum of all NSNumbers the array", ^
		{
			NSArray *numbers = @[@1, @5, @10, @3, @(-1), @22, @1, @55, @3.2];
			
			[[[numbers ct_sum] should] equal:99.2 withDelta:FLT_EPSILON];
		});
	});
	
	context(@"sum with number block", ^
	{
		it(@"should return the sum of all values returned by the block", ^
		{
			NSArray *numbers = @[@[@1], @[@5], @[@10], @[@3.2]];
			
			NSNumber *sum = [numbers ct_sum:^NSNumber *(NSArray *array) { return [array firstObject]; }];
			
			[[sum should] equal:19.2 withDelta:FLT_EPSILON];
		});
	});
	
	context(@"arithmetic mean", ^
	{
		it(@"should return the correct value given an array of numbers", ^
		{
			NSArray *numbers = @[@1, @5, @10, @3.2];
			
			[[[numbers ct_average] should] equal:4.8 withDelta:FLT_EPSILON];
		});
	});
	
	context(@"arithmetic mean with number block", ^
	{
		it(@"should return the arithmetic mean of all valuesreturned by the number block", ^
		{
			NSArray *numbers = @[@[@1], @[@5], @[@10], @[@3.2]];
			
			NSNumber *mean = [numbers ct_average:^NSNumber *(id object) { return [object firstObject]; }];
			
			[[mean should] equal:4.8 withDelta:FLT_EPSILON];
		});
	});
});

SPEC_END