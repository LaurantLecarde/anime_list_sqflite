import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:anime_list_sqflite/db/sql_helper.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:gap/gap.dart';
import '../../model/anime_model.dart';
import '../../widgets/glow_text.dart';
import '../../widgets/my_snackbars.dart';
import '../../widgets/navigator.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _WatchingScreenState();
}

class _WatchingScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: _getAllFavourites(),
    );
  }
  _getAllFavourites(){
    return FutureBuilder(
      future: SqlHelper.getAllFavouriteAnimes(),
      builder: (context,snapshot){
        if (snapshot.data != null && snapshot.data?.isNotEmpty == true){
          final list = snapshot.data?.reversed.toList();
          return Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 4),
            child: GridView.builder(
                itemCount: list?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1 / 1.5),
                itemBuilder: (context, index) {
                  final data = list?[index];
                  return GlowContainer(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 2, color: Colors.white),
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 400,
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Stack(children: [
                            Image.file(
                              File(data?.image ?? ""),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                            Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              Colors.black.withOpacity(1.0),
                                              Colors.black.withOpacity(0.7),
                                              Colors.black.withOpacity(0.5),
                                              Colors.black.withOpacity(0.0),
                                            ])),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          AppText(text: data?.name ?? ""),
                                          AppText(text: '${data?.episodes}')
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                            Positioned(
                                top: 0, right: 0, child: _columIcons(data!)),
                          ]),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else if (snapshot.data?.isEmpty == true){
          return const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add Your Favourite Anime",
                      style: TextStyle(color: Colors.blueAccent)),
                ],
              ));
        }else{
          return const Center(child: CupertinoActivityIndicator());
        }
      },
    );
  }

  _columIcons(Anime anime) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black45,
          // color: Colors.white70,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  // _saveFavouriteAnime(anime);
                },
                icon: const GlowIcon(CupertinoIcons.heart, color: Colors.red)),
            IconButton(
                onPressed: () {},
                icon: const GlowIcon(CupertinoIcons.tv,
                    color: Colors.indigoAccent)),
            IconButton(
                onPressed: () {},
                icon: const GlowIcon(CupertinoIcons.stop,
                    color: Colors.yellowAccent)),
            IconButton(
                onPressed: () {
                  _showDeleteDialog(anime);
                },
                icon: const GlowIcon(CupertinoIcons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
  }

  _showDeleteDialog(Anime anime) {
    return AwesomeDialog(
      borderSide: const BorderSide(
        width: 2,
        color: Colors.indigoAccent,
      ),
      width: 400,
      dialogBackgroundColor: const Color(0xff001686),
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(20),
          const AppText(text: "Are You Sure You Wanna Delete"),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _unDeleteButton(),
              _deleteButton(anime),
            ],
          ),
          const Gap(30),
        ],
      ),
    )..show();
  }

  _deleteButton(Anime anime) {
    return GlowButton(
        color: Colors.red,
        glowColor: Colors.red,
        width: 150,
        height: 50,
        child: const Center(child: Text("Yes, Delete")),
        onPressed: () {
          _deleteIt(anime.id, context);
          popNavigator(context);
        });
  }

  _unDeleteButton() {
    return GlowButton(
        color: Colors.indigoAccent,
        glowColor: Colors.indigoAccent,
        width: 150,
        height: 50,
        child: const Center(child: Text("No,Don't Delete")),
        onPressed: () {
          popNavigator(context);
        });
  }

  void _deleteIt(int? id, BuildContext context) {
    SqlHelper.deleteAnime(id).then((value) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(showMySnackBar("Deleted",
          "Anime Deleted Successfully", Colors.red, ContentType.warning));
    });
  }
}
