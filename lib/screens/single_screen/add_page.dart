import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../db/sql_helper.dart';
import '../../model/anime_model.dart';
import 'main_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _name = TextEditingController();
  final _desc = TextEditingController();
  SignTypes _selectedType = SignTypes.warning;

  final _picker = ImagePicker();
  XFile? _xFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        value: e, child: Text(e.name)))
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
      onTap: _showBottom,
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
  _showBottom() {
    showCupertinoModalPopup(context: context, builder: (dialogContext) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(onPressed: () => _pickImage(ImageSource.gallery), child: const Text("Gallery")),
        CupertinoActionSheetAction(onPressed: () => _pickImage(ImageSource.camera), child: const Text("Camera")),
        CupertinoActionSheetAction(onPressed: () => Navigator.of(context).pop(), isDestructiveAction: true,
            child: const Text("Cancel")),
      ],
    ));
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("SAVEDDDDDDDDD")));
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const MainPage()), (route) => false);
    });
    SqlHelper.getAllSigns();
  }
}


enum SignTypes {
  warning, grant, ban, command,
}