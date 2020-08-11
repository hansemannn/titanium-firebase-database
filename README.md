# Firebase Database - Titanium Module

Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Supporting this effort

The whole Firebase support in Titanium is developed and maintained by the community (`@hansemannn` and `@m1ga`). To keep
this project maintained and be able to use the latest Firebase SDK's, please see the "Sponsor" button of this repository,
thank you!

## Requirements

-   [x] The [Firebase Core](https://github.com/hansemannn/titanium-firebase-core) module
-   [x] Titanium SDK 6.3.0+

## ToDo's

-   [ ] Property format nested lists in this Readme

## API's

### `FirebaseDatabase`

#### Methods

-   `getReference(arguments)` -> `FirebaseDatabaseReference`
      \- `identifier` (String), `path` (String) **OR** `url` (String)
      \- `observableEvents` ([`DATA_EVENT_TYPE_*`])

-   `getFirebaseServerTimestamp()`

### `FirebaseDatabaseReference`

#### Methods

-   `child(arguments)` -> `FirebaseDatabaseReference`
    -   `identifier` (String), `path` (String) **OR** `url` (String)
         \- `observableEvents` ([`DATA_EVENT_TYPE_*`])


-   `childByAutoId(arguments)` -> `FirebaseDatabaseReference`

    -   `identifier` (String), `path` (String) **OR** `url` (String)
         \- `observableEvents` ([`DATA_EVENT_TYPE_*`])

-   `root(arguments)` -> `FirebaseDatabaseReference`
     \- `observableEvents` ([`DATA_EVENT_TYPE_*`])

-   `parent(arguments)` -> `FirebaseDatabaseReference`

    -   `observableEvents` ([`DATA_EVENT_TYPE_*`])

-   `setValue(value, callback)`

    -   `value` (Any)
         \- `callback` (optional, Function)

-   `removeValue(callback)`
     \- `callback` (optional, Function)

-   `updateChildValues(childValues, callback)`
     \- `childValues` (Dictionary)
     \- `callback` (optional, Function)

-   `setPriority(priority, callback)`
     \- `priority` (Any)
     \- `callback` (optional, Function)

-   `goOnline()`

-   `goOffline()`

-   `keepSynced(synced)`
     \- `synced` (Boolean)

#### Properties

-   `key` (String)

-   `url` (String)

#### Constants

-   `DATA_EVENT_TYPE_VALUE`
-   `DATA_EVENT_TYPE_CHILD_ADDED`
-   `DATA_EVENT_TYPE_CHILD_CHANGED`
-   `DATA_EVENT_TYPE_CHILD_MOVED`
-   `DATA_EVENT_TYPE_CHILD_REMOVED`

## Events

Important note: Events are added and removed generically. They are only fired if you observe them via
the `observableEvents` parameter.

-   `value` (via `DATA_EVENT_TYPE_VALUE`)
-   `add` (via `DATA_EVENT_TYPE_CHILD_ADDED`)
-   `change` (via `DATA_EVENT_TYPE_CHILD_CHANGED`)
-   `move` (via `DATA_EVENT_TYPE_CHILD_MOVED`)
-   `remove` (via `DATA_EVENT_TYPE_CHILD_REMOVED`)

## Example

```js
// Require the Firebase Database module
var FirebaseDatabase = require('firebase.database');

// Inserting values in firebase database
var fdRef = FirebaseDatabase.getReference().childByAutoId({
	path: 'user'
});

fdRef.setValue({
	username: 'username',
	email: 'test@example.com',
	password: 'ABCXYZ',
	timestamp: FirebaseDatabase.getFirebaseServerTimestamp()
}, function(e) {
	Ti.API.info('Value written, snapshot: ' + JSON.stringify(e, null, 4));
});

// Fetching values from Firebase database

var userRef = FirebaseDatabase.getReference({
	path: 'user',
	observableEvents: [FirebaseDatabase.DATA_EVENT_TYPE_CHILD_ADDED, FirebaseDatabase.DATA_EVENT_TYPE_VALUE]
});

userRef.addEventListener('value', function(e) {
	Ti.API.info('DATA_EVENT_TYPE_VALUE, snapshot: ' + JSON.stringify(e, null, 4));
});

userRef.addEventListener('add', function(e) {
	Ti.API.info('DATA_EVENT_TYPE_CHILD_ADDED, snapshot: ' + JSON.stringify(e, null, 4));
});

```

-   [Example](https://github.com/RavindraChherke/titanium-firebase-database/blob/new_functions/example/app.js)

## Build

```js
cd ios
appc run -p ios --build-only
```

## Legal

This module is Copyright (c) 2018-present by Hans Knöchel, Inc. All Rights Reserved.
