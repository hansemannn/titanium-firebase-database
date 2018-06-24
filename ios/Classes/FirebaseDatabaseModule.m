/**
 * titanium-firebase-database
 *
 * Created by Hans Knöchel
 * Copyright (c) 2018 by Hans Knöchel. All rights reserved.
 */

#import "FirebaseDatabaseModule.h"
#import "FirebaseDatabaseReferenceProxy.h"

#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation FirebaseDatabaseModule

#pragma mark Internal

MAKE_SYSTEM_PROP(DATA_EVENT_TYPE_VALUE, FIRDataEventTypeValue);
MAKE_SYSTEM_PROP(DATA_EVENT_TYPE_CHILD_ADDED, FIRDataEventTypeChildAdded);
MAKE_SYSTEM_PROP(DATA_EVENT_TYPE_CHILD_REMOVED, FIRDataEventTypeChildRemoved);
MAKE_SYSTEM_PROP(DATA_EVENT_TYPE_CHILD_MOVED, FIRDataEventTypeChildMoved);
MAKE_SYSTEM_PROP(DATA_EVENT_TYPE_CHILD_CHANGED, FIRDataEventTypeChildChanged);

- (id)moduleGUID
{
  return @"70e51a34-9140-4f84-bc9b-59960d99fbf8";
}

- (NSString *)moduleId
{
  return @"firebase.database";
}

#pragma Public APIs

- (FirebaseDatabaseReferenceProxy *)getReference:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);

  NSString *identifier = [arguments objectForKey:@"identifier"];
  NSString *path = [arguments objectForKey:@"path"];
  NSString *url = [arguments objectForKey:@"url"];
  NSArray *observableEvents = [arguments objectForKey:@"observableEvents"];

  FIRDatabaseReference *reference = nil;

  if (identifier != nil) {
    reference = [[[FIRDatabase database] reference] child:identifier];
  } else if (path != nil) {
    reference = [[FIRDatabase database] referenceWithPath:path];
  } else if (url != nil) {
    reference = [[FIRDatabase database] referenceFromURL:url];
  }

  if (reference == nil) {
    [self throwException:@"Cannot construct database reference" subreason:@"No valid key (identifier, path or url) found" location:CODELOCATION];
  }

  return [[FirebaseDatabaseReferenceProxy alloc] _initWithPageContext:self.pageContext
                                                 andDatabaseReference:reference
                                                     observableEvents:observableEvents];
}

- (NSDictionary *)firebaseServerTimestamp
{
    return [FIRServerValue timestamp];
}

@end
