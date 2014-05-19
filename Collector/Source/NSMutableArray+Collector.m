//
//  NSMutableArray+Collector.m
//  Collector
//
//  Created by Michaël Fortin on 2014-05-19.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import "NSMutableArray+Collector.h"

@implementation NSMutableArray (Collector)

- (BOOL)ct_addObjectIfNoneEquals:(id)object
{
	if (![self containsObject:object])
	{
		[self addObject:object];
		return YES;
	}
	return NO;
}

- (BOOL)ct_addObjectIfNotNil:(id)object
{
	if (object != nil)
	{
		[self addObject:object];
		return YES;
	}
	return NO;
}

@end