import 'package:flutter/material.dart';

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final menus = Column(
      children: <Widget>[
        ListTile(
          title: Text("Logout"),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("johndoe@testfairy.com"),
            ),
            menus
          ],
        ),
      ),
      body: Center(
        child: Text("Hello"),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.ac_unit),
        onPressed: () {},
      ),
    );
  }
}
