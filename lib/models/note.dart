class Note {
  int _id = -1;
  String _title = "";
  String _description = "";
  String _date = "";
  int _priority = 0;

  Note(this._title, this._date, this._priority, this._description);

  Note.withId(
      this._id, this._title, this._date, this._priority, this._description);

  int get id => _id;

  String get title => _title;

  set title(String value) {
    if (value.length <= 255) {
      _title = value;
    }
  }

  String get description => _description;

  set description(String value) {
    if (value.length <= 255) {
      _description = value;
    }
  }

  int get priority => _priority;

  set priority(int value) {
    if (1 <= value && value <= 2) {
      _priority = value;
    }
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    if (_id > -1) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    _id = map['id'];
    _title = map['title'];
    _description = map['description'];
    _priority = map['priority'];
    _date = map['date'];
  }
}
