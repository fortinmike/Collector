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
			[[[@[@1, @2, @3] firstObject] should] equal:@1];
		});
		
		it(@"should return nil when there are no objects in the array", ^
		{
			[[[@[] firstObject] should] beNil];
		});
	});
});

SPEC_END