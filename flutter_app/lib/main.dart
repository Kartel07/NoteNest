import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/notes_provider.dart';
import 'screens/notes_screen.dart';
import 'services/storage_service.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => NotesProvider(StorageService())..load(),
    child: const NoteNestApp(),
  ));
}

class NoteNestApp extends StatelessWidget {
  const NoteNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder()),
      ),
      home: const NotesScreen(),
    );
  }
}
