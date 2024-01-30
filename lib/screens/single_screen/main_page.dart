import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../bottom_screens/favourite_screen.dart';
import '../bottom_screens/finished_screen.dart';
import '../bottom_screens/home_page.dart';
import '../bottom_screens/watching_screen.dart';
import 'add_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _pages =const [
    HomePage(),
    WatchingScreen(),
    FinishedScreen(),
    FavouriteScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SalomonBottomBar(
              backgroundColor: Colors.indigoAccent,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: [
                SalomonBottomBarItem(
                    activeIcon:const Icon(CupertinoIcons.house_fill),
                    selectedColor: Colors.black,
                    unselectedColor: Colors.white,
                    icon:const Icon(CupertinoIcons.home),
                    title:  Text("Home",style: TextStyle(color: _selectedIndex == 0 ?Colors.white : Colors.black ),)),
                SalomonBottomBarItem(
                    activeIcon:const Icon(CupertinoIcons.tv_fill),
                    selectedColor: Colors.black,
                    unselectedColor: Colors.white,
                    icon:const Icon(CupertinoIcons.tv),
                    title: Text("Watching",style: TextStyle(color: _selectedIndex == 1 ?Colors.white : Colors.black ))),
                SalomonBottomBarItem(
                    activeIcon:const Icon(Icons.stop),
                    selectedColor:Colors.black,
                    unselectedColor: Colors.white,
                    icon:const Icon(CupertinoIcons.stop),
                    title: Text("Finished",style: TextStyle(color: _selectedIndex == 2 ?Colors.white : Colors.black ))),
                SalomonBottomBarItem(
                    activeIcon:const Icon(CupertinoIcons.heart_fill),
                    selectedColor: Colors.black,
                    unselectedColor: Colors.white,
                    icon:const Icon(CupertinoIcons.heart),
                    title: Text("Favourite",style: TextStyle(color: _selectedIndex == 3 ?Colors.white : Colors.black ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigate() {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const AddPage()));
  }
}

