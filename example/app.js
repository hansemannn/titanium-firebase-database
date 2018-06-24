var FirebaseCore = require('firebase.core');
var FirebaseDatabase = require('firebase.database');

var plistFile = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, 'GoogleService-Info.plist');

if (!plistFile.exists()) {
  alert('Please add your GoogleService-Info.plist file.');
  return;
}

try {
  FirebaseCore.configure();
} catch (e) {
  Ti.API.error('Error configuring Firebase: ' + e);
}

var window = Ti.UI.createWindow({
  title: 'Firebase Database',
});

var nav = Ti.UI.iOS.createNavigationWindow({
  window: window
});

var tableHeader = Ti.UI.createView({
  layout: 'vertical',
  height: Ti.UI.SIZE
});

var userNameTextField = Ti.UI.createTextField({
  borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
  top: 50,
  left: 15,
  right: 15,
  hintText: 'Enter unique username'
});

var userEmailTextField = Ti.UI.createTextField({
  borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
  top: 20,
  left: 15,
  right: 15,
  hintText: 'Enter email',

});

var userPasswordTextField = Ti.UI.createTextField({
  borderStyle: Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
  top: 20,
  left: 15,
  right: 15,
  hintText: 'Enter password',
  passwordMask: true
});

var registerButton = Ti.UI.createButton({
  left: 15,
  right: 15,
  top: 20,
  title: 'Register'
});

var table = Ti.UI.createTableView({
  headerView: tableHeader
});

registerButton.addEventListener('click', function(e) {

  if (userNameTextField.value.length == 0 || userEmailTextField.value.length == 0 || userPasswordTextField.value.length == 0) {
    alert('Please fill all details');
    return;
  }

  var fdRef = FirebaseDatabase.getReference().childByAutoId({
    path: 'user',
  });

  fdRef.setValue({
    username: userNameTextField.value,
    email: userEmailTextField.value,
    password: userPasswordTextField.value,
    timestamp: FirebaseDatabase.getFirebaseServerTimestamp()
  }, function(e) {
    Ti.API.info('Value written, snapshot: ' + JSON.stringify(e));
  });

});

tableHeader.add(userNameTextField);
tableHeader.add(userEmailTextField);
tableHeader.add(userPasswordTextField);
tableHeader.add(registerButton);

window.add(table);

var userRef = FirebaseDatabase.getReference({
  path: 'user',
  observableEvents: [FirebaseDatabase.DATA_EVENT_TYPE_CHILD_ADDED, FirebaseDatabase.DATA_EVENT_TYPE_VALUE]
});

userRef.addEventListener('value', function(e) {
  Ti.API.info('DATA_EVENT_TYPE_VALUE, snapshot: ' + JSON.stringify(e, null, 4));

  var tableData = [];
  var response = e.value;

  for (var key in response) {
    var user_info = response[key];
    tableData.push({
      title: user_info.username + ' : ' + user_info.email,
    });
  }
  table.setData(tableData);
});
userRef.addEventListener('add', function(e) {
  Ti.API.info('DATA_EVENT_TYPE_CHILD_ADDED, snapshot: ' + JSON.stringify(e, null, 4));
});

nav.open();
