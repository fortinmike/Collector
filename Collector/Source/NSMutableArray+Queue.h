//
//  NSMutableArray+Queue.h
//  Collector
//
//  Created by Michaël Fortin on 2014-05-19.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Queue)

- (void)ct_enqueue:(id)object;
- (id)ct_dequeue;

@end