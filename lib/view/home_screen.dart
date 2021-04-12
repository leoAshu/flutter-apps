import 'package:flutter/material.dart';
import './all_tab.dart';
import './favourites_tab.dart';
import '../utility/constants.dart';
import '../model/comics_database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int activeTab = 0;
  List<Widget> tabs = [AllTab(), FavoritesTab()];

  @override
  void dispose() {
    ComicsDatabase.getInstance().closeConnectionToDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.bgColor,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text('xkcd.com'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Constants.tabHomeLabel,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: Constants.tabFavLabel)
        ],
        backgroundColor: Constants.primaryColor,
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Constants.bgColor,
        currentIndex: activeTab,
        onTap: (value) {
          setState(() {
            this.activeTab = value;
          });
        },
      ),
      body: this.tabs[this.activeTab],
    );
  }
}
