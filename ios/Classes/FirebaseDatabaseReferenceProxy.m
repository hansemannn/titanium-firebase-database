/**
 * titanium-firebase-database
 *
 * Created by Hans Knöchel
 * Copyright (c) 2018 by Hans Knöchel. All rights reserved.
 */

#import "FirebaseDatabaseReferenceProxy.h"
#import "TiUtils.h"

@implementation FirebaseDatabaseReferenceProxy

#pragma mark - Internal

- (void)dealloc
{
  [_reference removeAllObservers];
}

- (id)_initWithPageContext:(id<TiEvaluator>)context
      andDatabaseReference:(FIRDatabaseReference *)reference
          observableEvents:(NSArray<NSNumber *> *)observableEvents
{
  if (self = [super _initWithPageContext:context]) {
    _reference = reference;
    if (observableEvents != nil) {
      for (NSNumber *observableEvent in observableEvents) {
        [_reference observeEventType:[TiUtils intValue:observableEvent]
                           withBlock:^(FIRDataSnapshot *_Nonnull snapshot) {
                             [self _sendEvent:@{ @"value" : [snapshot value] } forEventType:[TiUtils intValue:observableEvent]];
                           }];
      }
    }
  }

  return self;
}

#pragma mark - Public API's

#pragma mark Methods

- (FirebaseDatabaseReferenceProxy *)child:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);

  NSString *identifier = [arguments objectForKey:@"identifier"];
  NSString *path = [arguments objectForKey:@"path"];
  NSString *url = [arguments objectForKey:@"url"];
  NSArray *observableEvents = [arguments objectForKey:@"observableEvents"];

  FIRDatabaseReference *reference = nil;

  if (identifier != nil) {
    reference = [[[FIRDatabase database] reference] child:identifier];
  }

  if (path != nil) {
    reference = [[FIRDatabase database] referenceWithPath:path];
  }

  if (url != nil) {
    reference = [[FIRDatabase database] referenceFromURL:url];
  }

  if (reference == nil) {
    [self throwException:@"Cannot construct database reference" subreason:@"No valid key (identifier, path or url) found" location:CODELOCATION];
  }

  return [[FirebaseDatabaseReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                 andDatabaseReference:reference
                                                     observableEvents:observableEvents];
}

- (void)setValue:(NSArray *)arguments
{
  id value = [arguments objectAtIndex:0];

  if ([arguments count] == 0) {
    [_reference setValue:value];
    return;
  }

  KrollCallback *callback = [arguments objectAtIndex:1];
  __weak __typeof__(self) weakSelf = self;

  [_reference setValue:value
      withCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
        __typeof__(self) strongSelf = weakSelf;
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObjectsAndKeys:NUMBOOL(error == nil), @"success", nil];

        [callback call:@[ event ] thisObject:strongSelf];
      }];

  [_reference setValue:value];
}

- (void)removeValue:(NSArray *)arguments
{
  if ([arguments count] == 0) {
    [_reference removeValue];
    return;
  }

  KrollCallback *callback = [arguments objectAtIndex:1];
  __weak __typeof__(self) weakSelf = self;

  [_reference removeValueWithCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
    __typeof__(self) strongSelf = weakSelf;
    NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObjectsAndKeys:NUMBOOL(error == nil), @"success", nil];

    [callback call:@[ event ] thisObject:strongSelf];
  }];
}

- (void)updateChildValues:(NSArray *)arguments
{
  NSDictionary *childValues = [arguments objectAtIndex:0];

  if ([arguments count] == 1) {
    [_reference updateChildValues:childValues];
    return;
  }

  KrollCallback *callback = [arguments objectAtIndex:1];
  __weak __typeof__(self) weakSelf = self;

  [_reference updateChildValues:childValues
            withCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
              __typeof__(self) strongSelf = weakSelf;
              NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObjectsAndKeys:NUMBOOL(error == nil), @"success", nil];

              [callback call:@[ event ] thisObject:strongSelf];
            }];
}

- (void)setPriority:(NSArray *)arguments
{
  id priority = [arguments objectAtIndex:0];

  if ([arguments count] == 0) {
    [_reference setPriority:priority];
    return;
  }

  KrollCallback *callback = [arguments objectAtIndex:1];
  __weak __typeof__(self) weakSelf = self;

  [_reference setPriority:priority
      withCompletionBlock:^(NSError *_Nullable error, FIRDatabaseReference *_Nonnull ref) {
        __typeof__(self) strongSelf = weakSelf;
        NSMutableDictionary *event = [NSMutableDictionary dictionaryWithObjectsAndKeys:NUMBOOL(error == nil), @"success", nil];

        [callback call:@[ event ] thisObject:strongSelf];
      }];
}

- (void)goOnline:(id)unused
{
  [FIRDatabaseReference goOnline];
}

- (void)goOffline:(id)unused
{
  [FIRDatabaseReference goOffline];
}

- (void)keepSynced:(NSNumber *)synced
{
  [_reference keepSynced:[TiUtils boolValue:synced]];
}

#pragma mark Properties

- (NSString *)key
{
  return _reference.key;
}

- (NSString *)url
{
  return _reference.URL;
}

- (FirebaseDatabaseReferenceProxy *)parent
{
  return [[FirebaseDatabaseReferenceProxy alloc] _initWithPageContext:self.pageContext andDatabaseReference:_reference.parent observableEvents:nil];
}

- (FirebaseDatabaseReferenceProxy *)root
{
  return [[FirebaseDatabaseReferenceProxy alloc] _initWithPageContext:self.pageContext andDatabaseReference:_reference.root observableEvents:nil];
}

#pragma mark - Utilities

- (void)_sendEvent:(NSDictionary *)event forEventType:(FIRDataEventType)eventType
{
  NSString *identifier = nil;

  if (eventType == FIRDataEventTypeValue) {
    identifier = @"value";
  } else if (eventType == FIRDataEventTypeChildAdded) {
    identifier = @"add";
  } else if (eventType == FIRDataEventTypeChildRemoved) {
    identifier = @"remove";
  } else if (eventType == FIRDataEventTypeChildMoved) {
    identifier = @"move";
  } else if (eventType == FIRDataEventTypeChildChanged) {
    identifier = @"change";
  }

  if (identifier == nil) {
    [self throwException:@"Invalid constant passed" subreason:@"Expected one of DATA_EVENT_TYPE_*" location:CODELOCATION];
  }

  [self fireEvent:identifier withObject:event];
}

@end
