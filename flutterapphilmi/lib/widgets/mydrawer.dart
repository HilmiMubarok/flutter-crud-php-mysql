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
            accountName: Text('Hilmi'),
            accountEmail: Text('m.hilmimubarok@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/29186495?v=4'),
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
