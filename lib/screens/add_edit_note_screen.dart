import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../services/note_provider.dart';

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  AddEditNoteScreen({this.note});

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 8,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final note = Note(
                  id: widget.note?.id,
                  title: _titleController.text,
                  content: _contentController.text,
                  timestamp: DateFormat.yMMMd().add_jm().format(DateTime.now()),
                );
                if (widget.note == null) {
                  Provider.of<NoteProvider>(context, listen: false)
                      .addNote(note);
                } else {
                  Provider.of<NoteProvider>(context, listen: false)
                      .updateNote(note);
                }
                Navigator.pop(context);
              },
              child: Text(widget.note == null ? 'Add' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
