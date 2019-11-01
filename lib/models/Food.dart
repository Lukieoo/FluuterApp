class Note {

  int _id;
  String _title;
  String _description;
  String _store;
  String _product;

  Note(this._title, this._store, this._product, [this._description]);

  Note.withId(this._id, this._title, this._store, this._product, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get product => _product;

  String get store => _store;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set product(String newPriority) {

      this._product = newPriority;

  }

  set store(String newDate) {
    this._store = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['product'] = _product;
    map['store'] = _store;

    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._product = map['product'];
    this._store = map['store'];
  }
}

