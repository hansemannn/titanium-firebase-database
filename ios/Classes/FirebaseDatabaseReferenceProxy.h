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

- (void)setValue:(NSArray *)arguments;

- (void)removeValue:(NSArray *)arguments;

- (void)updateChildValues:(NSArray *)childValues;

- (void)setPriority:(NSArray *)arguments;

- (void)goOnline:(__unused id)unused;

- (void)goOffline:(__unused id)unused;

- (void)keepSynced:(NSNumber *)synced;

- (NSString *)key;

- (NSString *)url;

- (FirebaseDatabaseReferenceProxy *)parent;

- (FirebaseDatabaseReferenceProxy *)root;

@end
