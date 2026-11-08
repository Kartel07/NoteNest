import 'package:flutter_test/flutter_test.dart';
import 'package:notenest/models/note.dart';

void main() {
  test('Note survives a JSON round trip', () {
    final n = Note(
        id: '1', title: 'Hello', content: 'World', updatedAt: DateTime(2026, 11, 8));
    final back = Note.fromJson(n.toJson());
    expect(back.title, 'Hello');
    expect(back.content, 'World');
    expect(back.updatedAt, n.updatedAt);
  });
}
