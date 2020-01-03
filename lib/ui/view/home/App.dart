import 'package:flutter/material.dart';
import 'package:flutterfire/ui/view/home/fire_home_view.dart';
import 'package:flutterfire/ui/view/home/profile.dart';
import 'package:flutterfire/ui/view/home/history.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 1;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        history(),
        FireHomeView(),
        profile(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text("History"),
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(Icons.person),
          ),
        ],
        onTap: _onBarItemTap,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onBarItemTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
