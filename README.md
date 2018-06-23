# Firebase Database - Titanium Module

Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Requirements

-   [x] The [Firebase Core](https://github.com/hansemannn/titanium-firebase-core) module
-   [x] Titanium SDK 6.3.0+

## ToDo's

-   [ ] Property format nested lists in this ReadMe

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

//Inserting values in firebase database
var fdRef = FirebaseDatabase.getReference().childByAutoId({
		path : "user" ,
	});

	fdRef.setValue({
		username : "username",
		email : "test@gmailcom",
		password : "ABCXYZ",
		timestamp : FirebaseDatabase.getFirebaseServerTimestamp()
	}, function(e) {
		Ti.API.info("Value write callback, Data Snapshot " + JSON.stringify(e));
	});

//Fetching values from firebase database


var userRef = FirebaseDatabase.getReference({
	path : "user",
	observableEvents : [FirebaseDatabase.DATA_EVENT_TYPE_CHILD_ADDED, FirebaseDatabase.DATA_EVENT_TYPE_VALUE]
});

userRef.addEventListener("value", function(e) {
	Ti.API.info("DATA_EVENT_TYPE_VALUE Data Snapshot " + JSON.stringify(e));
});
userRef.addEventListener("add", function(e) {
	Ti.API.info("DATA_EVENT_TYPE_CHILD_ADDED Data Snapshot " + JSON.stringify(e));
});

```

-   [example](https://github.com/RavindraChherke/titanium-firebase-database/blob/new_functions/example/app.js)

## Build

```js
cd ios
appc ti build -p ios --build-only
```

## Legal

This module is Copyright (c) 2018-present by Hans Knöchel, Inc. All Rights Reserved.
