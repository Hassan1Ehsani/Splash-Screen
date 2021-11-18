import 'package:flutter/material.dart';
import 'package:splash_screen/widgets/custom_text_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Image.asset(
                  'images/intro.png',
                  height: 270,
                ),
              ),
            ),
            SizedBox(
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
                  onPressed: () {},
                  child: Text(
                    'SignUp',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
