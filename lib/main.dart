import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/note_repository.dart';
import 'providers/notes_provider.dart';
import 'screens/notes_home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(NotesApp(repository: NoteRepository()));
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key, required this.repository});

  final NoteRepository repository;

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF2F6F5E);

    return ChangeNotifierProvider(
      create: (_) => NotesProvider(repository),
      child: MaterialApp(
        title: 'Notes',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: const Color(0xFFF6F3EC),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: Brightness.dark,
          ),
        ),
        home: const NotesHomePage(),
      ),
    );
  }
}
