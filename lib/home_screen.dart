import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splash_screen/functions.dart';
import 'package:splash_screen/global_var.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  String userName;
  String userNamber;
  String carPrice;
  String carModel;
  String carColor;
  String descreption;
  String urlImage;
  String carLocation;

  QuerySnapshot cars;
  carMethods carobj = new carMethods();

  Future<bool> showDialogForAddingData() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Post a new Add",
              style: TextStyle(
                  fontSize: 24, fontFamily: "Bebas", letterSpacing: 2),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(hintText: "Enter Your Name"),
                  onChanged: (value) {
                    this.userName = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "Enter Your Phone Number"),
                  onChanged: (value) {
                    this.userNamber = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Car Price"),
                  onChanged: (value) {
                    this.carPrice = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Car Name"),
                  onChanged: (value) {
                    this.carModel = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Car Color"),
                  onChanged: (value) {
                    this.carColor = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Car Location"),
                  onChanged: (value) {
                    this.carLocation = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration:
                      InputDecoration(hintText: "Write Car Description"),
                  onChanged: (value) {
                    this.descreption = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter image URL"),
                  onChanged: (value) {
                    this.urlImage = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Map<String, dynamic> carData = {
                    'userName': userName,
                    'uId': userId,
                    'userNumber': userNamber,
                    'carPrice': carPrice,
                    'carModel': carModel,
                    'carColor': carColor,
                    'carLocation': carLocation,
                    'description': descreption,
                    'urlImage': urlImage,
                    'imagPro': userImageUrl,
                    'time': DateTime.now(),
                  };
                  print("car data: $carData");
                  carobj.addData(carData).then((value) {
                    print("Data Added Successfully");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: Text(
                  "Add Now",
                ),
              ),
            ],
          );
        });
  }

  getMyData() {
    FirebaseFirestore.instance.collection('users').doc(userId).get().then(
      (result) {
        setState(
          () {
            userImageUrl = result.data()['imgPro'];
            getUsername = result.data()['username'];
          },
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
    userEmail = FirebaseAuth.instance.currentUser.email;

    carobj.getData().then((result) {
      setState(() {
        cars = result;
      });
    });
    getMyData();
  }

  @override
  Widget build(BuildContext context) {
    Widget showCarsList() {
      if (cars != null) {
        return ListView.builder(
          itemCount: cars.docs.length,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, i) {
            return Card(
              child: Column(
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                cars.docs[i].data()['imgPro'],
                              ),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    title: GestureDetector(
                      onTap: () {},
                      child: Text(
                        cars.docs[i].data()['username'],
                      ),
                    ),
                    subtitle: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            cars.docs[i].data()['carLocation'],
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    trailing: cars.docs[i].data()['uId'] == userId
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(Icons.edit_outlined),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onDoubleTap: () {},
                                child: Icon(Icons.delete_forever_sharp),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [],
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Image.network(
                      cars.docs[i].data()['urlImage'],fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                  child:Text('\$'+cars.docs[i].data()['carPrice'],
                  style: TextStyle(
                    fontFamily: "Bebas",
                    letterSpacing: 2,
                    fontSize: 24,),
                    ),
                  ),
                ],
                  
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.login_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.redAccent],
            ),
          ),
        ),
        title: Text("Home Page"),
      ),
      body: Center(
        child: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Post',
        child: Icon(Icons.add),
        onPressed: () {
          showDialogForAddingData();
        },
      ),
    );
  }
}
