import 'package:flutter/material.dart';
import 'package:splash_screen/authentication_screen.dart';

class ErrorAlertDialog extends StatelessWidget {
  // const ErrorAlertDialog({Key? key}) : super(key: key);

  final String message;
  ErrorAlertDialog(this.message);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        ElevatedButton(
            onPressed: () {
              Route newRoute = MaterialPageRoute(
                builder: (context) => AuthenticationScreen(),
              );
              Navigator.pushReplacement(context, newRoute);
            },
            child: Center(child: Text('OK'),)),
      ],
    );
  }
}
