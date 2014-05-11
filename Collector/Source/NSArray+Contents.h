//
//  NSArray+Contents.h
//  Collector
//
//  Created by Michaël Fortin on 2014-05-11.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Contents)

#pragma mark Array Contents Checking

- (BOOL)containsObjects:(NSArray *)array; // Returns whether the array contains the same objects as the parameter or more
- (BOOL)containsOnlyObjects:(NSArray *)array; // Returns whether the array contains exactly the same objects as the parameter, not more
- (BOOL)containsAnyObject:(NSArray *)objects;
- (BOOL)areObjectsKindOfClass:(Class)klass; // Checks whether all objects in the array are of the specified class or any of its subclasses

@end