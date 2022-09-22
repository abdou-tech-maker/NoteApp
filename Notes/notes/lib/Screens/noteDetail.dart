import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NoteDetail extends StatefulWidget {
  String title;
  NoteDetail(this.title);
  @override
  State<NoteDetail> createState() => NoteDetailState(title);
}

class NoteDetailState extends State<NoteDetail> {
  TextEditingController crtl1 = TextEditingController();
  TextEditingController crtl2 = TextEditingController();
  String title;

  NoteDetailState(this.title);

  static var _properties = ['high', 'low'];
  var _curentvalue = 'low';
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
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
                    items: _properties.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    style: textStyle,
                    value: _curentvalue,
                    onChanged: (String newvalue) {
                      dropDownChange(newvalue);
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
    Navigator.pop(context);
  }

  void dropDownChange(newvalue) {
    setState(() {
      this._curentvalue = newvalue;
    });
  }
}
