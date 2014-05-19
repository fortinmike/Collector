//
//  NSMutableArray+StackSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-19.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSMutableArray+Stack.h"


SPEC_BEGIN(NSMutableArray_StackSpec)

describe(@"NSMutableArray+Stack", ^
{
	context(@"push", ^
	{
		it(@"should add the object at the end of the array", ^
		{
			NSMutableArray *array = [@[@1, @2, @3] mutableCopy];
			
			[array ct_push:@4];
			
			[[array should] equal:@[@1, @2, @3, @4]];
		});
	});
	
	context(@"pop", ^
	{
		it(@"should take and remove an object from the end of the array", ^
		{
			NSMutableArray *array = [@[@1, @2, @3] mutableCopy];
			
			[[[array ct_pop] should] equal:@3];
			[[array should] equal:@[@1, @2]];
		});
		
		it(@"should return nil when the array is empty", ^
		{
			NSMutableArray *array = [@[@1] mutableCopy];
			
			[[[array ct_pop] should] equal:@1];
			[[[array ct_pop] should] beNil];
		});
	});
});

SPEC_END