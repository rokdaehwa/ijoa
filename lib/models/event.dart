class Event {
  int id;
  String date;
  String childTag;
  String field;
  String subField;
  int playNumber;
  int weekNumber;
  bool isPlayed;

  Event(
      {this.id,
      this.date,
      this.childTag,
      this.field,
      this.subField,
      this.playNumber,
      this.weekNumber,
      this.isPlayed});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'childTag': childTag,
      'field': field,
      'subField': subField,
      'playNumber': playNumber,
      'weekNumber': weekNumber,
      'isPlayed': isPlayed,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, date: $date, childTag: $childTag, field: $field, subField: $subField, playNumber: $playNumber, weekNumber: $weekNumber, isPlayed: $isPlayed}';
  }

}

List<Event> eventModelList = [
  Event(
      id: 1,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'sociality',
      subField: '협동적 조형활동',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 2,
      date: '2020-05-06',
      childTag: '해찬이',
      field: 'selfEsteem',
      subField: '협동적 조형활동',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 3,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'creativity',
      subField: '협동적 조형활동',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 4,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'happiness',
      subField: '협동적 조형활동',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
  Event(
      id: 5,
      date: '2020-05-06',
      childTag: '기상이',
      field: 'science',
      subField: '협동적 조형활동',
      playNumber: 1,
      weekNumber: 2,
      isPlayed: false),
];
