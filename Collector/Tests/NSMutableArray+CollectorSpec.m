//
//  NSMutableArray+CollectorSpec.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-19.
//  Copyright 2014 Michaël Fortin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSMutableArray+Collector.h"


SPEC_BEGIN(NSMutableArray_CollectorSpec)

describe(@"NSMutableArray+Collector", ^
{
	context(@"add object if none equals", ^
	{
		it(@"should add an object that has no equal in the receiver", ^
		{
			NSMutableArray *array = [@[@1, @2] mutableCopy];
			
			BOOL success = [array ct_addObjectIfNoneEquals:@3];
			
			[[array should] equal:@[@1, @2, @3]];
			[[theValue(success) should] beYes];
		});
		
		it(@"should not add an object that already exists in the receiver", ^
		{
			NSMutableArray *array = [@[@1, @2, @3] mutableCopy];
			
			BOOL success = [array ct_addObjectIfNoneEquals:@2];
			
			[[array should] equal:@[@1, @2, @3]];
			[[theValue(success) should] beNo];
		});
	});
	
	context(@"add object if not nil", ^
	{
		it(@"should add to the array if the argument is non-nil", ^
		{
			NSMutableArray *array = [@[@1, @2] mutableCopy];
			
			BOOL success = [array ct_addObjectIfNotNil:@3];
			
			[[array should] equal:@[@1, @2, @3]];
			[[theValue(success) should] beYes];
		});
		
		it(@"should not add to the array if the argument is nil", ^
		{
			NSMutableArray *array = [@[@1, @2] mutableCopy];
			
			BOOL success = [array ct_addObjectIfNotNil:nil];
			
			[[array should] equal:@[@1, @2]];
			[[theValue(success) should] beNo];
		});
	});
});

SPEC_END
