class Note {
  int _id;
  String _title;
  String _description;
  int _priority;
  String _date;

//Constructor
  Note(this._title, this._date, this._priority, [this._description]);
  Note.withId(this._id, this._title, this._priority, this._date,
      [this._description]);
// Defining Getters
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;
//Defining Setters
  set title(String newTitle) {
    if (newTitle.length < 100) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

//Converting the "Note" Object Into a Map Object In Order To Be Stored In SQFLITE Data Base
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['decription'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  //Extract a Note Object From Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._priority = map['priority'];
    this._description = map['description'];
  }
}
