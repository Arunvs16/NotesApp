import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_login/add_note.dart';
import 'package:just_login/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Notes> list = [];
  late SharedPreferences sharedPreferences;
  getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? StringList = sharedPreferences.getStringList('list');
    print(StringList);
    if (StringList != null) {
      setState(() {
        list =
            StringList.map((item) => Notes.fromMap(jsonDecode(item))).toList();
      });
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            child: Text(
              'Your Notes',
              style: TextStyle(
                fontSize: 30,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          list.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: const Center(
                    child: Text(
                      'No Texts',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              sharedPreferences.remove('list');
                              list.remove(list[index]);
                            });
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        title: Text(
                          list[index].title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(list[index].description),
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotes()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue.shade300,
      ),
    );
  }
}
