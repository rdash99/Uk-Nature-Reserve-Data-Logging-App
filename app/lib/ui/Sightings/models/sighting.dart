class Sighting {
  String _name;
  String _date;
  String _time;
  int _num;

  Sighting(this._name, this._date, this._time, this._num);
}

class SightingList {
  List<Sighting> sightingList;

  SightingList({this.sightingList});
}
