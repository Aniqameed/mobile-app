import 'package:flutter/material.dart';
import '../models/note.dart';
import 'db_helper.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];

  List<Note> get notes => _notes;
  List<Note> get filteredNotes => _filteredNotes;

  Future<void> fetchNotes() async {
    try {
      _notes = await DBHelper().getNotes();
      _filteredNotes = _notes;
      notifyListeners();
    } catch (e) {
      print("Error fetching notes: $e");
    }
  }

  Future<void> addNote(Note note) async {
    await DBHelper().addNote(note);
    await fetchNotes();
  }

  Future<void> updateNote(Note note) async {
    await DBHelper().updateNote(note);
    await fetchNotes();
  }

  Future<void> deleteNote(int id) async {
    await DBHelper().deleteNote(id);
    await fetchNotes();
  }

  void filterNotes(String query) {
    if (query.isEmpty) {
      _filteredNotes = _notes;
    } else {
      _filteredNotes = _notes
          .where((note) =>
      note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
