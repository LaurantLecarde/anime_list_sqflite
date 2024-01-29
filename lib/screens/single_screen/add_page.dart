import 'dart:io';
import 'package:anime_list_sqflite/widgets/drawer_hidden.dart';
import 'package:anime_list_sqflite/widgets/my_snackbars.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../db/sql_helper.dart';
import '../../model/anime_model.dart';


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {


  final _name = TextEditingController();
  final _desc = TextEditingController();
  SignTypes _selectedType = SignTypes.dub;

  final _picker = ImagePicker();
  XFile? _xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Add New Rule"),
        actions: [
          IconButton(onPressed: () {
            _saveNewRule();
          }, icon: const Icon(CupertinoIcons.checkmark))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            _imageSection(),
            const Gap(20),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                hintText: "Sign name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
            ),
            const Gap(20),
            TextField(
              controller: _desc,
              decoration: InputDecoration(
                hintText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),
            ),
            const Gap(20),
            DropdownButtonHideUnderline(
                child: DropdownButtonFormField<SignTypes>(
                  focusColor: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.indigo, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                      hintText: 'Sign type',
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    style: const TextStyle(
                        fontSize: 14, color: Colors.black87),
                    value: _selectedType,
                    items: SignTypes.values
                        .map((e) => DropdownMenuItem(
                        value: e, child: Text(e.name,style: TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (i) {
                      setState(() {
                        _selectedType = i!;
                      });
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Color(0xff64748B),
                    ))),
          ],
        ),
      ),
    );
  }
  Widget _imageSection() {
    return InkWell(
      onTap: _showMaterialBottom,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2)
        ),
        child: SizedBox(
          height: 280,
          child: Center(
            child: _xFile == null ? const Icon(CupertinoIcons.photo) : Image.file(
              File(_xFile?.path ?? "") // -> import qil -> dart:io
            ),
          ),
        ),
      ),
    );
  }

  _showMaterialBottom(){
    showDialog(context: (context), builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Choose the method",style: TextStyle(color: Colors.indigo),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: ()=> _pickImage(ImageSource.gallery),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Center(child: Text("Gallery",style: TextStyle(color: Colors.white))),
              ),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: ()=> _pickImage(ImageSource.camera),
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const Center(child: Text("Camera",style: TextStyle(color: Colors.white))),
              ),
            ),
          ],
        ),
        actions: [
          CupertinoButton(child: Text("Cancle",style: TextStyle(color: Colors.red),), onPressed: ()=> Navigator.of(context).pop())
        ],
      );
    },);
  }

  _pickImage(ImageSource source) async {
    _xFile = null;
    _xFile = await _picker.pickImage(source: source);
    setState(() {
    });
  }

  void _saveNewRule(){
    final newRule = Anime(null,_name.text,_desc.text,_selectedType.toString(),_xFile?.path);
    SqlHelper.saveSign(newRule).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(mySaveSnackBar);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const MyHiddenDrawer()), (route) => false);
    });
    SqlHelper.getAllSigns();
  }


}

enum SignTypes {
  sub, dub, subTVMovie, dubTVMovie,
}

/// ICONS => Favourite, Watching, Finished, Delete,