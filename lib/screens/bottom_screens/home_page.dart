import 'dart:io';
import 'package:anime_list_sqflite/screens/single_screen/add_page.dart';
import 'package:anime_list_sqflite/widgets/my_snackbars.dart';
import 'package:anime_list_sqflite/widgets/navigator.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import '../../db/sql_helper.dart';
import '../../model/anime_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.indigo,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          onPressed: () => navigator(context, const AddPage()),
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        body: _allAnimeGet());
  }

  void _deleteIt(int? id, BuildContext context) {
    SqlHelper.deleteSign(id).then((value) {
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(showMySnackBar("Deleted", "Anime Deleted Successfully", Colors.red, ContentType.warning));
    });
  }

  void _showDialog(Anime anime) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text("Delete"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      _deleteIt(anime.id, context);
                    },
                    child: const Text("DELETE"))
              ],
            ));
  }

  _allAnimeGet() {
    return FutureBuilder(
      future: SqlHelper.getAllSigns(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
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
                    border: Border.all(
                      width: 2,
                      color: Colors.white
                    ),
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
                            Positioned(
                              top: 0,
                              right: 0,
                                child: _columIcons(data!))
                          ]),
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return const Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Start Adding Animes",
                  style: TextStyle(color: Colors.blueAccent)),
            ],
          ));
        }
      },
    );
  }
  _columIcons(Anime anime){
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
            IconButton(onPressed: (){
              _showDialog(anime);
            }, icon:const GlowIcon(CupertinoIcons.heart,color: Colors.red)),
            IconButton(onPressed: (){_showDialog(anime);}, icon:const GlowIcon(CupertinoIcons.tv,color: Colors.indigoAccent)),
            IconButton(onPressed: (){_showDialog(anime);}, icon:const GlowIcon(CupertinoIcons.stop,color: Colors.yellowAccent)),
            IconButton(onPressed: (){
              setState(() {
                _showDialog(anime);
              });
            }, icon:const GlowIcon(CupertinoIcons.delete,color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
