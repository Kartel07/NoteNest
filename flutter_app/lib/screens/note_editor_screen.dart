import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../providers/notes_provider.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? note;
  const NoteEditorScreen({super.key, this.note});
  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late final TextEditingController _title =
      TextEditingController(text: widget.note?.title ?? '');
  late final TextEditingController _content =
      TextEditingController(text: widget.note?.content ?? '');

  Future<void> _save() async {
    if (_title.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Title is required')));
      return;
    }
    final provider = context.read<NotesProvider>();
    if (widget.note == null) {
      await provider.add(_title.text.trim(), _content.text);
    } else {
      await provider.update(widget.note!.id, _title.text.trim(), _content.text);
    }
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    await context.read<NotesProvider>().remove(widget.note!.id);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New note' : 'Edit note'),
        actions: [
          if (widget.note != null)
            IconButton(
                tooltip: 'Delete',
                icon: const Icon(Icons.delete_outline),
                onPressed: _delete),
          IconButton(
              tooltip: 'Save',
              icon: const Icon(Icons.check),
              onPressed: _save),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          TextField(
            controller: _title,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TextField(
              controller: _content,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(labelText: 'Write your note…'),
            ),
          ),
        ]),
      ),
    );
  }
}
