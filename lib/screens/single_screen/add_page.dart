import 'dart:io';
import 'package:anime_list_sqflite/widgets/drawer_hidden.dart';
import 'package:anime_list_sqflite/widgets/glow_text.dart';
import 'package:anime_list_sqflite/widgets/my_snackbars.dart';
import 'package:anime_list_sqflite/widgets/my_textfiled.dart';
import 'package:anime_list_sqflite/widgets/navigator.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final _episode = TextEditingController();
  SignTypes _selectedType = SignTypes.dub;

  final _picker = ImagePicker();
  XFile? _xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const AppText(text: "Add New Anime"),
        leading: IconButton(onPressed: ()=>Navigator.of(context).pop(),icon: Icon(CupertinoIcons.back,color: Colors.indigoAccent)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(child: AppText(text: "Image")),
              const Gap(10),
              Center(child: _imageSection()),
              const Gap(20),
              AppText(text: 'Name',),
              const Gap(10),
              MyTextField(controller: _name, hintText: "Anime Name", isNumber: false),
              const Gap(20),
              AppText(text: "Episodes",),
              const Gap(10),
              MyTextField(controller: _episode, hintText: "Anime Episodes", isNumber: true),
              const Gap(20),
              AppText(text: "Type"),
              const Gap(10),
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
                                color: Colors.indigoAccent, width: 2),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      style: const TextStyle(
                          fontSize: 14, color: Colors.indigoAccent),
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
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8),
        child: GlowButton(
          height: 50,
          borderRadius: BorderRadius.circular(15),
          onPressed: (){
            _saveNewRule();},
          child:  GlowText("Save",style: GoogleFonts.rowdies(fontSize: 20,color: Colors.white)),
        ),
      ),
    );
  }
  Widget _imageSection() {
    return InkWell(
      onTap: _showDeleteDialog,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.indigoAccent, width: 2)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 300,
            width: 200,
            child: Center(
              child: _xFile == null ? const Icon(CupertinoIcons.photo,color: Colors.white,) : Image.file(
                File(_xFile?.path ?? "",),fit: BoxFit.cover,width: double.infinity,height: double.infinity, // -> import qil -> dart:io
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showDeleteDialog() {
    return AwesomeDialog(
      borderSide: const BorderSide(
        width: 2,
        color: Colors.indigoAccent,
      ),
      width: 400,
      dialogBackgroundColor: Color(0xff001686),
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(10),
            const Center(child: AppText(text: "Where From Do You Give Images?")),
            const Gap(20),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {pickImage(ImageSource.gallery);popNavigator(context);},
                  child: GlowContainer(
                    height: 50,
                    width: 100,
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(12),
                    child: const Center(
                        child:
                        Text("Gallery", style: TextStyle(color: Colors.white))),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: (){ pickImage(ImageSource.camera);popNavigator(context);},
                  child: GlowContainer(
                    height: 50,
                    width: 100,
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(12),
                    child: const Center(
                        child: Text("Camera", style: TextStyle(color: Colors.white))),
                  ),
                ),
              ],
            ),
            const Gap(20),
            InkWell(
                onTap: (){
                  popNavigator(context);
                },
                child: GlowText("Cancle",style: GoogleFonts.rowdies(color: Colors.red,fontSize: 20),glowColor: Colors.red)),
            const Gap(10),
          ],
        ),
      ),
    )..show();
  }

  pickImage(ImageSource source) async {
    _xFile = null;
    _xFile = await _picker.pickImage(source: source);
    setState(() {
    });
  }

  void _saveNewRule(){
    final newRule = Anime(null,_name.text,_episode.text,_selectedType.toString(),_xFile?.path);
    SqlHelper.saveSign(newRule).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(showMySnackBar("Saved", "Your anime saved successfully✅", CupertinoColors.activeGreen, ContentType.success));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const MyHiddenDrawer()), (route) => false);
    });
    SqlHelper.getAllSigns();
  }


}

enum SignTypes {
  sub, dub, subTVMovie, dubTVMovie,
}

/// ICONS => Favourite, Watching, Finished, Delete,