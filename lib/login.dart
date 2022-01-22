import 'package:flutter/material.dart';
import 'package:splash_screen/DialogBox/error_dialog.dart';
import 'package:splash_screen/DialogBox/loading_dialog.dart';
import 'package:splash_screen/home_screen.dart';
import 'package:splash_screen/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                  'images/intro.png',
                  height: 250,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                      _emailController, Icons.person, 'Email', false),
                  // controller:_emailController, data:Icons.person, hintText:'Email', isObsecure:false
                  CustomTextField(
                      _passwordController, Icons.lock, 'passwprd', true),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  _emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty
                      ? _login()
                      : showDialog(
                          context: context,
                          builder: (con) {
                            return ErrorAlertDialog(
                                "Please the write the required info for the login");
                          },
                        );
                },
                child: Text(
                  'Log in',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    showDialog(
        context: context,
        builder: (con) {
          return LoadingAlertDialog('Please Waite');
        });
    User currentUser;
    await _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con) {
            return ErrorAlertDialog(error.message.toString());
          });
    });
    if (currentUser != null) {
      Navigator.pop(context);
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    } else {
      print("Error");
    }
  }
}
