import 'dart:io';

import 'package:anime_list_sqflite/screens/single_screen/add_page.dart';
import 'package:anime_list_sqflite/widgets/navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          .showSnackBar(const SnackBar(content: Text("DELETED")));
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
            padding: const EdgeInsets.only(left: 8.0,right: 8,top: 4),
            child: GridView.builder(
              itemCount: list?.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5,childAspectRatio: 1/1.5),
                itemBuilder: (context, index) {
                  final data = list?[index];
                  return InkWell(
                    onTap: () {},
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(children: [
                          Image.file(File(data?.image ?? ""),fit: BoxFit.cover,width: double.infinity,height: double.infinity,),
                        ]),
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
              Text("Start Adding\n \t  Animes",
                  style: TextStyle(color: Colors.blueAccent)),
              Icon(Icons.data_saver_off_rounded)
            ],
          ));
        }
      },
    );
  }
}
