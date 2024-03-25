import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_login/model.dart';
import 'package:just_login/notes_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Notes> list = [];
  late SharedPreferences sharedPreferences;
  void setData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? stringList = sharedPreferences.getStringList('list');
    if (stringList != null) {
      setState(() {
        list =
            stringList.map((item) => Notes.fromMap(jsonDecode(item))).toList();
      });
    }
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                TextField(
                  controller: title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                ),
                TextField(
                  controller: description,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Start Typing',
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              list.add(Notes(title: title.text, description: description.text));
              List<String> stringList =
                  list.map((item) => jsonEncode(item.toMap())).toList();
              sharedPreferences.setStringList('list', stringList);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const NotesScreen()));
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
