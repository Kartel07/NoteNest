import 'package:flutter/foundation.dart';
import '../models/note.dart';
import '../services/storage_service.dart';

class NotesProvider extends ChangeNotifier {
  final StorageService storage;
  NotesProvider(this.storage);

  List<Note> notes = [];
  bool loading = true;

  Future<void> load() async {
    notes = await storage.loadNotes();
    _sort();
    loading = false;
    notifyListeners();
  }

  void _sort() => notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

  Future<void> _persist() async {
    _sort();
    notifyListeners();
    await storage.saveNotes(notes);
  }

  Future<void> add(String title, String content) async {
    notes.add(Note(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    ));
    await _persist();
  }

  Future<void> update(String id, String title, String content) async {
    final i = notes.indexWhere((n) => n.id == id);
    if (i == -1) return;
    notes[i] = Note(
        id: id, title: title, content: content, updatedAt: DateTime.now());
    await _persist();
  }

  Future<void> remove(String id) async {
    notes.removeWhere((n) => n.id == id);
    await _persist();
  }
}
