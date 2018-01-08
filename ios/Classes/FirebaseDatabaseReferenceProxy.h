/**
 * titanium-firebase-database
 *
 * Created by Hans Knöchel
 * Copyright (c) 2018 by Hans Knöchel. All rights reserved.
 */

#import "TiProxy.h"

#import <FirebaseDatabase/FirebaseDatabase.h>

@interface FirebaseDatabaseReferenceProxy : TiProxy {
  FIRDatabaseReference *_reference;
}

- (id)_initWithPageContext:(id<TiEvaluator>)context andDatabaseReference:(FIRDatabaseReference *)reference observableEvents:(NSArray<NSNumber *> *)observableEvents;

- (FirebaseDatabaseReferenceProxy *)child:(id)arguments;

- (void)setValue:(id)value;

- (void)removeValue:(id)unused;

- (void)updateChildValues:(id)childValues;

- (void)setPriority:(NSNumber *)priority;

@end
