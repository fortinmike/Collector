//
//  NSMutableArray+QueueSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-19.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSMutableArray+Queue.h"


SPEC_BEGIN(NSMutableArray_QueueSpec)

describe(@"NSMutableArray+Queue", ^
{
	context(@"enqueue", ^
	{
		it(@"should add the object at the end of the array", ^
		{
			NSMutableArray *array = [@[@1, @2, @3] mutableCopy];
			
			[array ct_enqueue:@4];
			
			[[array should] equal:@[@1, @2, @3, @4]];
		});
	});
	
	context(@"dequeue", ^
	{
		it(@"should take and remove an object at the start of the array", ^
		{
			NSMutableArray *array = [@[@1, @2, @3] mutableCopy];
			
			[[[array ct_dequeue] should] equal:@1];
			[[array should] equal:@[@2, @3]];
		});
		
		it(@"should return nil when the array is empty", ^
		{
			NSMutableArray *array = [@[@1] mutableCopy];
			
			[[[array ct_dequeue] should] equal:@1];
			[[[array ct_dequeue] should] beNil];
		});
	});
});

SPEC_END