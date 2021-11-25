import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class carMethods {
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(carData) async {
    if (isLoggedIn()) {
      FirebaseFirestore.instance
          .collection('Cars')
          .add(carData)
          .catchError((e) {
        print(e);
      });
    } else {
      print("You need to be sign in");
    }
  }

  getData() async {
    return await FirebaseFirestore.instance
        .collection('Cars')
        .orderBy("time", descending: true)
        .get();
  }

  updateData(SelectedDoc, newValue) {
    FirebaseFirestore.instance
        .collection('Cars')
        .doc(SelectedDoc)
        .update(newValue)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    FirebaseFirestore.instance
        .collection('Cars')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
