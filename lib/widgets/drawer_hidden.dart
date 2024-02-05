import 'package:anime_list_sqflite/screens/drawer_screens/settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';
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
            name: "👑 Anime Page",
            baseStyle: GoogleFonts.rowdies(color: Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const MainPage()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "📖 Manga Page",
            baseStyle: GoogleFonts.rowdies(color: Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const MangaScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "📺 TV Movies Page",
            baseStyle: GoogleFonts.rowdies( color:Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const TvMoviesScreen()),ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "⚙️ Settings",
            baseStyle: GoogleFonts.rowdies( color:Colors.indigoAccent.shade400,fontWeight: FontWeight.bold,fontSize: 20),
            selectedStyle: const TextStyle(color: Colors.white),
          ),
          const SettingsScreen()),
    ];

    return HiddenDrawerMenu(
      backgroundColorAppBar:Theme.of(context).primaryColor,
        actionsAppBar: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: ()=>navigator(context,const SearchScreen()),
                child:const GlowIcon(CupertinoIcons.search,color: Colors.indigoAccent,glowColor: Colors.indigoAccent)),
          )
        ],
        leadingAppBar:const Icon(Icons.format_list_bulleted,color: Colors.indigoAccent,),
        isTitleCentered: true,
        tittleAppBar: GlowText("AniMania",style: GoogleFonts.rowdies(color: Colors.indigoAccent),glowColor: Colors.indigoAccent,),
        withAutoTittleName: true,
        elevationAppBar: 15,
        screens: screens,
        backgroundColorMenu: Colors.black);
  }
}
