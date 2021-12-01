import 'package:flutter/material.dart';
import 'package:splash_screen/DialogBox/error_dialog.dart';
import 'package:splash_screen/global_var.dart';
import 'package:splash_screen/home_screen.dart';
import 'package:splash_screen/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';

class Register extends StatefulWidget {
  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _phoneConfirmController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 0), () {
      saveUserData(d: {
        'username': '_nameController.text.trim()',
        'uId': 'userId',
        'userNumber': '_phoneConfirmController.text.trim()',
        'imagePro': '_imageController.text.trim()',
        'time': 'DateTime.now()'
      });
    });
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  'images/intro.png',
                  height: 270,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(_nameController, Icons.person, 'Name', false),
                  CustomTextField(
                      _phoneConfirmController, Icons.phone, 'phone', false),
                  CustomTextField(
                      _emailController, Icons.email, 'Email', false),
                  CustomTextField(
                      _passwordController, Icons.lock, 'password', true),
                  CustomTextField(_passwordConfirmController, Icons.lock,
                      'Confirm password', true),
                  CustomTextField(_imageController, Icons.camera_alt_outlined,
                      'Image URL', false),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: ElevatedButton(
                onPressed: () {
                  _register();
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void saveUserData({Map<String, dynamic> d}) {
    Map<String, dynamic> userData = {
      'username': _nameController.text.trim(),
      'uId': userId,
      'userNumber': _phoneConfirmController.text.trim(),
      'imagePro': _imageController.text.trim(),
      'time': DateTime.now()
    };
    userData = d ?? userData;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(userData)
        .then((value) => print("done: $userData"))
        .catchError((e) {
      print("oh no: ");
      print(e);
    });
  }

  void _register() async {
    User currentUser;
    await _auth
        .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((auth) {
      currentUser = auth.user;
      userId = currentUser.uid;
      userEmail = currentUser.email;
      getUsername = _nameController.text.trim();

      saveUserData();
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return ErrorAlertDialog(error.message.toString());
            // return ErrorAlertDialog(message: error.message.toString());
          });
    });

    // currentUser;
    if (currentUser != null) {
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
  }
}
