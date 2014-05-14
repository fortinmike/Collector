//
//  CollectorBlockTypes.h
//  Collector
//
//  Created by Michaël Fortin on 2014-05-12.
//  Copyright (c) 2014 Michaël Fortin. All rights reserved.
//

#ifndef Collector_CollectorBlockTypes_h
#define Collector_CollectorBlockTypes_h

typedef void (^OperationBlock)(id object);
typedef BOOL (^ConditionBlock)(id object);
typedef id (^ValueBlock)(id object);
typedef NSNumber * (^NumberBlock)(id object);

#endif