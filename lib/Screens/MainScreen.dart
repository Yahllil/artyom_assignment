import 'package:artyom_assignment/Screens/CharactersScreen.dart';
import 'package:artyom_assignment/Screens/EpisodesScreen.dart';
import 'package:artyom_assignment/Screens/LocationsScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String _appBarTitle = "Episodes";

  List<Widget> _tabs = [
    EpisodesScreen(),
    CharactersScreen(),
    LocationsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _setupAppBarTitle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(_appBarTitle),
      ),
      body: Center(
        child: _tabs[_selectedIndex],
      ),
      bottomNavigationBar: _buildTabBar(),
    );
  }

  //MARK: - Widgets
  Widget _buildTabBar() {
    return BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tv_sharp),
            label: 'Episodes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_sharp),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Locations',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
    );
  }

  //MARK: - Private
  void _setupAppBarTitle() {
    switch(_selectedIndex) {
      case 0:
        _appBarTitle = "Episodes";
        break;
      case 1:
        _appBarTitle = "Characters";
        break;
      case 2:
        _appBarTitle = "Locations";
        break;
    }
  }
}