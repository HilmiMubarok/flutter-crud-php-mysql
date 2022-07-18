import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/store.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  // create drawer
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Hanna Laela'),
            accountEmail: Text('hannalaela.11@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://uas-hannalaela.000webhostapp.com/hanna.jpeg'),
            ),
          ),
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(
                          title: "Tugas Flutter",
                        )),
              );
            },
          ),
          ListTile(
            title: Text('My Store'),
            leading: Icon(Icons.store),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Store()),
              );
            },
          ),
        ],
      ),
    );
  }
}
