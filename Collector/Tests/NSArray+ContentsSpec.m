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

describe(@"NSArray+Contents", ^
{
	context(@"contains equal objects", ^
	{
		it(@"should return YES when the given array's objects are all found in the receiver", ^
		{
			NSArray *array1 = @[@1, @2, @3];
			NSArray *array2 = @[@3, @1, @2];
			NSArray *array3 = @[@1, @4, @3, @2];
			
			[[theValue([array1 ct_containsObjects:array2]) should] beYes];
			[[theValue([array2 ct_containsObjects:array1]) should] beYes];
			[[theValue([array3 ct_containsObjects:array1]) should] beYes];
		});
		
		it(@"should return NO when some of the objects in the given array are not found in the receiver", ^
		{
			NSArray *array1 = @[@1, @2, @3];
			NSArray *array2 = @[@50, @1, @2];
			NSArray *array3 = @[@1, @4, @3, @2];
			
			[[theValue([array1 ct_containsObjects:array2]) should] beNo];
			[[theValue([array1 ct_containsObjects:array3]) should] beNo];
		});
	});
	
	context(@"contains only objects", ^
	{
		it(@"should return YES when the receiver contains only the objects from the given array", ^
		{
			NSArray *array1 = @[@3, @1, @2];
			NSArray *array2 = @[@1, @2, @3];
			
			[[theValue([array1 ct_containsOnlyObjects:array2]) should] beYes];
		});
		
		it(@"should return NO when the receiver contains more than the objects from the givne array", ^
		{
			NSArray *array1 = @[@1, @4, @3, @2];
			NSArray *array2 = @[@1, @2, @3];
			
			[[theValue([array1 ct_containsOnlyObjects:array2]) should] beNo];
		});
	});
	
	context(@"contains any object", ^
	{
		it(@"should return YES when at least one of the objects in the given array is found in the receiver", ^
		{
			NSArray *array1 = @[@1, @4, @3, @2];
			NSArray *array2 = @[@50, @1, @60];
			
			[[theValue([array2 ct_containsAnyObject:array1]) should] beYes];
		});
		
		it(@"should return NO when no object in the given array is found in the receiver", ^
		{
			NSArray *array1 = @[@1, @4, @3, @2];
			NSArray *array2 = @[@50, @70, @60];
			
			[[theValue([array1 ct_containsAnyObject:array2]) should] beNo];
		});
	});
	
	context(@"are objects kind of class", ^
	{
		it(@"should return YES when all objects in the receiver are of the given class", ^
		{
			NSArray *array = @[@1, @2, @3];
			
			[[theValue([array ct_areObjectsKindOfClass:[NSNumber class]]) should] beYes];
		});
		
		it(@"should return NO when one or more object in the receiver is not of the given class", ^
		{
			NSArray *array = @[@1, @2, @"3"];
			
			[[theValue([array ct_areObjectsKindOfClass:[NSNumber class]]) should] beNo];
		});
	});
});

SPEC_END