import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_w7_assignment13_note_app/data/note_repository.dart';
import 'package:technical_w7_assignment13_note_app/main.dart';

void main() {
  testWidgets('shows empty state and can add a note', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(NotesApp(repository: NoteRepository(prefs)));
    await tester.pumpAndSettle();

    expect(find.text('Notes'), findsWidgets);
    expect(find.text('No notes yet'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('note_title_field')), 'Shopping');
    await tester.enterText(
      find.byKey(const Key('note_content_field')),
      'Milk and eggs',
    );
    await tester.tap(find.byKey(const Key('save_note_button')));
    await tester.pumpAndSettle();

    expect(find.text('Shopping'), findsOneWidget);
    expect(find.text('Milk and eggs'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('search_notes_field')), 'shop');
    await tester.pumpAndSettle();
    expect(find.text('Shopping'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('search_notes_field')), 'xyz');
    await tester.pumpAndSettle();
    expect(find.text('No matching notes'), findsOneWidget);
  });
}
