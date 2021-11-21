import 'package:flutter/material.dart';
import 'package:free_dongdong/screens/dong_screen.dart';
import 'package:free_dongdong/screens/home_screen.dart';
import 'package:free_dongdong/screens/list_screen.dart';
import 'package:free_dongdong/screens/summary_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
    BottomNavigationBarItem(icon: Icon(Icons.account_box), title: Text('Dong')),
    BottomNavigationBarItem(icon: Icon(Icons.storage), title: Text('List')),
    BottomNavigationBarItem(icon: Icon(Icons.wysiwyg_outlined), title: Text('Summary')),
  ];

  int _selectedIndex = 0;

  static List<Widget> _screens = <Widget> [
    HomeScreen(),
    DongScreen(),
    ListScreen(),
    SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: false,
          items: btmNavItems,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onBtmItemClick,
        ),
      ),
    );
  }
  void _onBtmItemClick(int index) {setState(() {
      _selectedIndex = index;
    });
  }
}
