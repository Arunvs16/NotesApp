import 'package:flutter/material.dart';
import 'package:just_login/add_note.dart';
import './notes_screen.dart';

void main() {
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NotesScreen(),
      routes: {
        './': (context) => const NotesScreen(),
        './add_note': (context) => const AddNotes(),
      },initialRoute: './',
    );
  }
}
