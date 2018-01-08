# Firebase Database - Titanium Module
Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Requirements
- [x] Titanium SDK 6.2.0 or later

## ToDo's

- [ ] Property format nested lists in this readme

## API's

### `FirebaseDatabase`

#### Methods

- `getReference(arguments)` -> `FirebaseDatabaseReference`
  - `identifier` (String), `path` (String) **OR** `url` (String)
  - `observableEvents` ([`DATA_EVENT_TYPE_*`])

### `FirebaseDatabaseReference`

#### Methods

- `child(arguments)` -> `FirebaseDatabaseReference`
  - `identifier` (String), `path` (String) **OR** `url` (String)
  - `observableEvents` ([`DATA_EVENT_TYPE_*`])

- `root(arguments)` -> `FirebaseDatabaseReference`
  - `observableEvents` ([`DATA_EVENT_TYPE_*`])
  
- `parent(arguments)` -> `FirebaseDatabaseReference`
  - `observableEvents` ([`DATA_EVENT_TYPE_*`])

- `setValue(value, callback)`
  - `value` (Any)
  - `callback` (optional, Function)

- `removeValue(callback)`
  - `callback` (optional, Function)
  
- `updateChildValues(childValues, callback)`
  - `childValues` (Dictionary)
  - `callback` (optional, Function)

- `setPriority(priority, callback)`
  - `priority` (Any)
  - `callback` (optional, Function)

- `goOnline()`

- `goOffline()`

- `keepSynced(synced)`
  - `synced` (Boolean)

#### Properties

- `key` (String)

- `url` (String)

#### Constants

- `DATA_EVENT_TYPE_VALUE`
- `DATA_EVENT_TYPE_ADD`
- `DATA_EVENT_TYPE_CHANGE`
- `DATA_EVENT_TYPE_MOVE`
- `DATA_EVENT_TYPE_REMOVE`

## Events

Important note: Events are added and removed generically. They are only fired if you observe them via
the `observableEvents` parameter.

- `value` (via `DATA_EVENT_TYPE_VALUE`)
- `add` (via `DATA_EVENT_TYPE_ADD`)
- `change` (via `DATA_EVENT_TYPE_CHANGE`)
- `move` (via `DATA_EVENT_TYPE_MOVE`)
- `remove` (via `DATA_EVENT_TYPE_REMOVE`)

## Example
```js
// Require the Firebase Database module
var FirebaseDatabase = require('firebase.database');

// TBA
```

## Build
```js
cd ios
appc ti build -p ios --build-only
```

## Legal

This module is Copyright (c) 2018-present by Hans Knöchel, Inc. All Rights Reserved.
Usage of this module is subject to the Terms of Service agreement with Appcelerator, Inc.

