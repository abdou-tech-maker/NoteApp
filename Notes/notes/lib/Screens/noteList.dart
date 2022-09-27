import 'package:flutter/material.dart';
import 'package:notes/Screens/noteDetail.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:notes/models/note.dart';
import 'package:notes/utils/dataBase_Helper.dart';

class NoteList extends StatefulWidget {
  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DataBaseHelper dataBaseHelper = new DataBaseHelper();
  List<Note> notelist;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (notelist == null) {
      // ignore: deprecated_member_use
      notelist = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Note('', '', 2), 'Add Note');
        },
        tooltip: 'Add Note',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.notelist[position].priority),
              child: getPriorityIcon(this.notelist[position].priority),
            ),
            title: Text(this.notelist[position].title),
            subtitle: Text(this.notelist[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                delete(context, notelist[position]);
              },
            ),
            onTap: () {
              debugPrint('listtile tapped ');
              navigateToDetail(this.notelist[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  //Returns the Priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;

        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  //Return The Priority Icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));
    if (result != false) {
      updateListView();
    }
  }

  void delete(BuildContext context, Note note) async {
    int result = await dataBaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Succesfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {
    final Future<Database> dbFuture = dataBaseHelper.initializeDataBase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = dataBaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.notelist = noteList;
          this.count = notelist.length;
        });
      });
    });
  }
}
