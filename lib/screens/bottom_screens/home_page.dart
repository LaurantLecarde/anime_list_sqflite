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
        body: FutureBuilder(
          future: SqlHelper.getAllSigns(),
          builder: (context,snapshot){
            if(snapshot.hasData ){
              final list = snapshot.data?.reversed.toList();
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context,index){
                  final data = list?[index];
                  return GestureDetector(
                      onLongPress: (){
                        _showDialog(data!);
                        Navigator.of(context).pop();
                      },
                      child: Center(child: Text("${data?.name}")));
                },
              );
            }else {
              return const Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Start Adding\n \t  Animes",style: TextStyle(color: Colors.blueAccent)),
                  Icon(Icons.data_saver_off_rounded)
                ],
              ));
            }
          },
        )
      );
    }

    void _deleteIt(int? id,BuildContext context){
      SqlHelper.deleteSign(id).then((value) {
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("DELETED")));
      });
    }

    void _showDialog(Anime anime) {
      showDialog(context: context, builder: (context)=>AlertDialog(
        content:const Text("Delete"),
        actions: [
          ElevatedButton(onPressed: (){
            _deleteIt(anime.id, context);
          }, child: const Text("DELETE"))
        ],
      ));
    }
}
