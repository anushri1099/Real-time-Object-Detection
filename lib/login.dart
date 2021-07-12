import 'package:flutter/material.dart';

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'signup.dart';
import 'home.dart';

void main() async => Login();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*CircleAvatar(
              radius: 70.0,
              backgroundImage: AssetImage('assets/Logo.PNG'),
            ),*/
            Text(
              'Tattva',
              style: TextStyle(
                //fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            /*Text(
              'User Login/Logout',
              style: TextStyle(
                //fontFamily: 'Source Sans Pro',
                color: Colors.black87,
                fontSize: 16.0,
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            ),*/
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: TextField(
                controller: controllerUsername,
                enabled: !isLoggedIn,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: TextField(
                controller: controllerPassword,
                enabled: !isLoggedIn,
                obscureText: true,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 2.0),
              child: TextButton(
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onPressed: isLoggedIn ? null : () => doUserLogin(),
              ),
            ),
            Container(
              child: TextButton(
                  child: const Text(
                    'New User? Register',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  }),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                child: const Text('Logout'),
                onPressed: !isLoggedIn ? null : () => doUserLogout(),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      showSuccess("User was successfully login!");
      // Navigator.push(
      // context,
      //MaterialPageRoute(builder: (context) => HomePage()),
      //);
      cam();
      setState(() {
        isLoggedIn = true;
      });
    } else {
      showError(response.error.message);
    }
  }

  void doUserLogout() async {
    final user = await ParseUser.currentUser();
    var response = await user.logout();
    if (response.success) {
      showSuccess("User was successfully logout!");
      setState(() {
        isLoggedIn = false;
      });
    } else {
      showError(response.error.message);
    }
  }
}
