import 'package:flutter/cupertino.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:flutter/material.dart';
import '../screens/drawer_screens/manga_screen.dart';
import '../screens/drawer_screens/tv_movie_screen.dart';
import '../screens/single_screen/main_page.dart';
import '../screens/single_screen/search_screen.dart';
import 'navigator.dart';

class MyHiddenDrawer extends StatelessWidget {
  const MyHiddenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var screens = <ScreenHiddenDrawer>[
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Anime Page",
            baseStyle: TextStyle(color: Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const MainPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Manga Page",
            baseStyle: TextStyle(color: Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const MangaScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "TV Movies Page",
            baseStyle: TextStyle( color:Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const TvMoviesScreen()),
    ];

    return HiddenDrawerMenu(
        actionsAppBar: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(onPressed: ()=>navigator(context,const SearchScreen()), icon: const Icon(CupertinoIcons.search,color: Colors.indigoAccent,)),
          )
        ],
        leadingAppBar:const Icon(Icons.format_list_bulleted,color: Colors.indigoAccent,),
        isTitleCentered: true,
        tittleAppBar:const Text("Anime List",style: TextStyle(color: Colors.indigoAccent)),
        withAutoTittleName: true,
        elevationAppBar: 0,
        screens: screens,
        backgroundColorMenu: Colors.blueAccent);
  }
}
