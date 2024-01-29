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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        onPressed: _navigate,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
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
              selectedColor: Colors.yellowAccent,
              unselectedColor: Colors.white,
              icon:const Icon(CupertinoIcons.home),
              title: const Text("Home")),
          SalomonBottomBarItem(
              activeIcon:const Icon(CupertinoIcons.tv_fill),
              selectedColor:const Color(0xff1000ff),
              unselectedColor: Colors.white,
              icon:const Icon(CupertinoIcons.tv),
              title:const Text("Watching")),
          SalomonBottomBarItem(
              activeIcon:const Icon(Icons.stop),
              selectedColor:const Color(0xffcae8fd),
              unselectedColor: Colors.white,
              icon:const Icon(CupertinoIcons.stop),
              title:const Text("Finished")),
          SalomonBottomBarItem(
            activeIcon:const Icon(CupertinoIcons.heart_fill),
              selectedColor: Colors.red,
              unselectedColor: Colors.white,
              icon:const Icon(CupertinoIcons.heart),
              title:const Text("Favourite")),
        ],
      ),
    );
  }

  _navigate() {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const AddPage()));
  }
}
