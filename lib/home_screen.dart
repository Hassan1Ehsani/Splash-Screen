import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            )),
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
        onPressed: () {},
      ),
    );
  }
}
