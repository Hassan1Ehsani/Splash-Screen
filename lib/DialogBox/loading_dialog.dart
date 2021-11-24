import 'package:flutter/material.dart';
import 'package:splash_screen/widgets/loading_widget.dart';

class LoadingAlertDialog extends StatelessWidget {
  // const LoadingAlertDialog({ Key key }) : super(key: key);

  final String message;
  LoadingAlertDialog(this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(height: 10,),
          Text('Athenticating, Please Wait...'),
        ],
      ),
    );
  }
}
