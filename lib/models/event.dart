class Event {
  int id;
  String date;
  String childTag;
  String field;
  int playNumber;
  int weekNumber;
  bool isPlayed;

  Event(
      {this.id,
      this.date,
      this.childTag,
      this.field,
      this.playNumber,
      this.weekNumber,
      this.isPlayed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'childTag': childTag,
      'field': field,
      'playNumber': playNumber,
      'weekNumber': weekNumber,
      'isPlayed': isPlayed,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, date: $date, childTag: $childTag, field: $field, playNumber: $playNumber, weekNumber: $weekNumber, isPlayed: $isPlayed}';
  }

}

List<Event> eventModelList = [
  Event(
      id: 1,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'sociality',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 2,
      date: '2020-05-06',
      childTag: '해찬이',
      field: 'selfEsteem',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 3,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'creativity',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 4,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'happiness',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 5,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'science',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
];
