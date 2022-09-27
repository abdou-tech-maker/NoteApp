import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/models/note.dart';
import 'package:notes/utils/dataBase_Helper.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class NoteDetail extends StatefulWidget {
  final String title;
  final Note note;
  NoteDetail(this.note, this.title);
  @override
  State<NoteDetail> createState() => NoteDetailState(note, title);
}

class NoteDetailState extends State<NoteDetail> {
  TextEditingController crtl1 = TextEditingController();
  TextEditingController crtl2 = TextEditingController();
  String title;
  Note note;

  NoteDetailState(this.note, this.title);

  static var _priorities = ['high', 'low'];
  DataBaseHelper helper = new DataBaseHelper();
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    TextStyle textStyle = Theme.of(context).textTheme.title;
    crtl1.text = note.title;
    crtl2.text = note.description;
    return WillPopScope(
        // ignore: missing_return
        onWillPop: () {
          moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: moveToLastScreen,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                    items: _priorities.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    style: textStyle,
                    value: updatePriorityAsString(note.priority),
                    onChanged: (valueSelectedByUser) {
                      setState(() {
                        updatePriorityAsInt(valueSelectedByUser);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: crtl1,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('dummy text field ');
                      udpdateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                //Third Element
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: crtl2,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint('dummy text field ');
                      udpateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                //Fourth Element
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          setState(() {
                            _save();
                          });
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ();
                              },
                            ),
                          );*/
                        },
                      )),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        child: Text('Delete'),
                        onPressed: () {
                          setState(() {
                            _delete();
                          });
                          /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ();
                              },
                            ),
                          );*/
                        },
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  //convert string priority to integer priority
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'high':
        note.priority = 1;
        break;
      case 'low':
        note.priority = 2;
        break;
    }
  }

  //convert Int Priority to String Priority
  String updatePriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0]; //high
        break;
      case 2:
        priority = _priorities[1]; //low
        break;
    }
    return priority;
  }

//Update The Title Of The Note Object
  void udpdateTitle() {
    note.title = crtl1.text;
  }

  //Update The Description Of The Note Object
  void udpateDescription() {
    note.description = crtl2.text;
  }

//Saving Or Updating a Note When Button Save is Clicked
  void _save() async {
    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (note.id != null) {
      result = await helper.updateNote(note);
    } else {
      result = await helper.insertInto(note);
    }
    if (result != 0) {
      _showAlertDialog('Status', 'Note Saved Successfuly');
    } else {
      _showAlertDialog('Status', 'Problem In Saving Note ');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _delete() async {
    moveToLastScreen();
//Case 1 Deleting When Comming from The Adding Button
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note Was Deleted');
      return;
    }
    int result = await helper.deleteNote(note.id);

    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfuly');
    } else {
      _showAlertDialog('Status', 'Problem In Deleting Note ');
    }
  }
}
