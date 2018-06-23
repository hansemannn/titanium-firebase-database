var FirebaseCore = require('firebase.core');
var FirebaseDatabase = require('firebase.database');

try {
	FirebaseCore.configure();
} catch(e) {
	Ti.API.info(e);
}

var f = Ti.Filesystem.getFile(Ti.Filesystem.resourcesDirectory, 'GoogleService-Info.plist');
if (f.exists() === false) {
	alert("Please add your GoogleService-Info.plist file.");
}

var window = Ti.UI.createWindow({
	title : "Firebase Database",
});

var tableHeader = Ti.UI.createView({
	layout : "vertical",
	height : Ti.UI.SIZE
});

var userNameTextField = Ti.UI.createTextField({
	borderStyle : Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
	top : "50dp",
	left : "15dp",
	right : "15dp",
	hintText : "Enter unique username"
});

var userEmailTextField = Ti.UI.createTextField({
	borderStyle : Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
	top : "20dp",
	left : "15dp",
	right : "15dp",
	hintText : "Enter email",

});

var userPasswordTextField = Ti.UI.createTextField({
	borderStyle : Ti.UI.INPUT_BORDERSTYLE_ROUNDED,
	top : "20dp",
	left : "15dp",
	right : "15dp",
	hintText : "Enter password",
	passwordMask : true
});

var registerButton = Ti.UI.createButton({
	left : "15dp",
	right : "15dp",
	top : "20dp",
	title : "Register"
});

var table = Ti.UI.createTableView({
	headerView : tableHeader,
});

registerButton.addEventListener("click", function(e) {

	if (userNameTextField.value.length == 0 || userEmailTextField.value.length == 0 || userPasswordTextField.value.length == 0) {
		alert("Please fill all details");
		return;
	}

	var fdRef = FirebaseDatabase.getReference().childByAutoId({
		path : "user" ,
	});

	fdRef.setValue({
		username : userNameTextField.value,
		email : userEmailTextField.value,
		password : userPasswordTextField.value,
		timestamp : FirebaseDatabase.getFirebaseServerTimestamp()
	}, function(e) {
		Ti.API.info("Value write callback, Data Snapshot " + JSON.stringify(e));
	});

});

tableHeader.add(userNameTextField);
tableHeader.add(userEmailTextField);
tableHeader.add(userPasswordTextField);
tableHeader.add(registerButton);

window.add(table);

var userRef = FirebaseDatabase.getReference({
	path : "user",
	observableEvents : [FirebaseDatabase.DATA_EVENT_TYPE_CHILD_ADDED, FirebaseDatabase.DATA_EVENT_TYPE_VALUE]
});

userRef.addEventListener("value", function(e) {
	Ti.API.info("DATA_EVENT_TYPE_VALUE Data Snapshot " + JSON.stringify(e));
	var tableData = [];
	var response = e.value;
	for (var key in response) {
		var user_info = response[key];
		tableData.push({
			title : user_info.username + " : " + user_info.email,

		});
	}
	table.setData(tableData);
});
userRef.addEventListener("add", function(e) {
	Ti.API.info("DATA_EVENT_TYPE_CHILD_ADDED Data Snapshot " + JSON.stringify(e));
});

window.open();

