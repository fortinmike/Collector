# Collector

[![Version](http://cocoapod-badges.herokuapp.com/v/Collector/badge.png)](http://cocoadocs.org/docsets/Collector)
[![Platform](http://cocoapod-badges.herokuapp.com/p/Collector/badge.png)](http://cocoadocs.org/docsets/Collector)

Ruby and LINQ-inspired categories on NSArray. Fully tested and documented.

*Contributions are welcome. Need something that isn't implemented? Send a pull request!*

## Features

- A safe (prefixed) set of category methods on NSArray.
- Fully tested (using the awesome [Kiwi](https://github.com/kiwi-bdd/Kiwi) library). Take a look at the tests for simple usage examples.
- Fully documented (method summaries are displayed when auto-complete is activated in Xcode 5+).

## Overview

- Using Collector, you get `-ct_map:`, `-ct_reduce:` and other Ruby-like methods that remove the need for a lot of array manipulation boilerplate. Eliminate duplicates using `-ct_distinct`, obtain the objects in a specified range using `-ct_objectsInRange:`, check if all objects in your array pass a given test using `-ct_all:`, `-ct_any:` and `-ct_none:`, and more.

- Some nice extensions to work with `NSNumber` arrays: `-ct_min`, `-ct_max`, `-ct_sum` and more.

- Quick and easy sorting.

## API

*Note: The following declarations might not be 100% up-to-date with the actual API Collector offers and are displayed here so you can get a feel for the library.*

### NSArray+Collector

```objc
- (NSArray *)ct_arrayByRemovingObject:(id)object;
- (NSArray *)ct_arrayByRemovingObjectsInArray:(NSArray *)array;
- (id)ct_first:(CollectorConditionBlock)condition;
- (id)ct_first:(CollectorConditionBlock)condition orDefault:(id)defaultObject;
- (id)ct_last:(CollectorConditionBlock)condition;
- (id)ct_last:(CollectorConditionBlock)condition orDefault:(id)defaultObject;
- (NSArray *)ct_where:(CollectorConditionBlock)condition;
- (NSArray *)ct_map:(CollectorValueBlock)valueBlock;
- (id)ct_reduce:(id(^)(id cumulated, id object))reducingBlock;
- (id)ct_reduceWithSeed:(id)seed block:(id(^)(id cumulated, id object))reducingBlock;
- (void)ct_each:(CollectorOperationBlock)operation;
- (void)ct_eachWithIndex:(void(^)(id object, NSUInteger index))operation;
- (NSArray *)ct_except:(CollectorConditionBlock)condition;
- (NSArray *)ct_take:(NSUInteger)amount;
- (NSArray *)ct_distinct;
- (NSArray *)ct_distinct:(CollectorValueBlock)valueBlock;
- (NSArray *)ct_objectsInRange:(NSRange)range;
- (NSArray *)ct_objectsOfKind:(Class)kind;
- (id)ct_winner:(id(^)(id object1, id object2))comparisonBlock;
- (BOOL)ct_all:(CollectorConditionBlock)testBlock;
- (BOOL)ct_any:(CollectorConditionBlock)testBlock;
- (BOOL)ct_none:(CollectorConditionBlock)testBlock;
- (NSUInteger)ct_count:(CollectorConditionBlock)testBlock;
```

### NSMutableArray+Queue

```objc
- (void)ct_enqueue:(id)object;
- (id)ct_dequeue;
```

### NSMutableArray+Stack

```objc
- (void)ct_push:(id)object;
- (id)ct_pop;
```

### NSArray+Contents

```objc
- (BOOL)ct_containsObjects:(NSArray *)array;
- (BOOL)ct_containsOnlyObjects:(NSArray *)array;
- (BOOL)ct_containsAnyObject:(NSArray *)objects;
- (BOOL)ct_areObjectsKindOfClass:(Class)klass;
```

### NSArray+Numbers

```objc
- (NSNumber *)ct_min;
- (NSNumber *)ct_min:(CollectorNumberBlock)numberBlock;
- (NSNumber *)ct_max;
- (NSNumber *)ct_max:(CollectorNumberBlock)numberBlock;
- (NSNumber *)ct_sum;
- (NSNumber *)ct_sum:(CollectorNumberBlock)numberBlock;
- (NSNumber *)ct_average;
- (NSNumber *)ct_average:(CollectorNumberBlock)numberBlock;
```

### NSArray+Sorting

```objc
- (NSArray *)ct_reversed;
- (NSArray *)ct_shuffled;
- (NSArray *)ct_orderedByAscending:(CollectorValueBlock)valueBlock;
- (NSArray *)ct_orderedByDescending:(CollectorValueBlock)valueBlock;
```

### NSMutableArray+Collector

```objc
- (BOOL)ct_addObjectIfNoneEquals:(id)object;
- (BOOL)ct_addObjectIfNotNil:(id)object;
```

## Installation

Collector is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "Collector"

## Author

Michaël Fortin (fortinmike@irradiated.net)

## License

Collector is available under the MIT license. See the LICENSE file for more info.

