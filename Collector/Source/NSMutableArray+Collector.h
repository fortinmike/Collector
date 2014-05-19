//
//  NSMutableArray+Collector.h
//  Collector
//
//  Created by Michaël Fortin on 2014-05-19.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Collector)

- (BOOL)ct_addObjectIfNoneEquals:(id)object;
- (BOOL)ct_addObjectIfNotNil:(id)object;

@end