import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';
import 'note_editor_screen.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  void _open(BuildContext context, [Note? note]) => Navigator.push(context,
      MaterialPageRoute(builder: (_) => NoteEditorScreen(note: note)));

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotesProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('NoteNest')),
      body: _body(context, provider),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _open(context),
        icon: const Icon(Icons.add),
        label: const Text('New note'),
      ),
    );
  }

  Widget _body(BuildContext context, NotesProvider provider) {
    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.notes.isEmpty) {
      return const Center(
          child: Text('No notes yet. Tap "New note" to add one.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: provider.notes.length,
      itemBuilder: (_, i) {
        final n = provider.notes[i];
        return Dismissible(
          key: ValueKey(n.id),
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            color: Colors.red.shade400,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) => provider.remove(n.id),
          child: Card(
            child: ListTile(
              title: Text(n.title, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle:
                  Text(n.content, maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () => _open(context, n),
            ),
          ),
        );
      },
    );
  }
}
