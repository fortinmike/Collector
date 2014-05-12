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
	context(@"first", ^
	{
		it(@"should return the first object when there are objects in the receiver", ^
		{
			[[[@[@1, @2, @3] first] should] equal:@1];
		});
		
		it(@"should return nil when there are no objects in the array", ^
		{
			[[[@[] first] should] beNil];
		});
	});
	
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
	
	context(@"where", ^
	{
		it(@"should return all objects that match the given condition", ^
		{
			NSArray *objects = @[@1, @2, @"Three", @4];
			NSArray *expectedObjects = @[@1, @2, @4];
			[[[objects where:^BOOL(id object) { return [object isKindOfClass:[NSNumber class]]; }] should] equal:expectedObjects];
		});
	});
});

SPEC_END