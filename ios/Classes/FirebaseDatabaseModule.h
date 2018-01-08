/**
 * titanium-firebase-database
 *
 * Created by Hans Knöchel
 * Copyright (c) 2018 by Hans Knöchel. All rights reserved.
 */

#import "FirebaseDatabaseReferenceProxy.h"
#import "TiModule.h"

@interface FirebaseDatabaseModule : TiModule {
}

- (FirebaseDatabaseReferenceProxy *)getReference:(id)arguments;

@end
