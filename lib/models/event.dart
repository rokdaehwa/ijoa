class Event {
  // int id;
  // String date;
  String childTag;
  String field;
  int playNumber;
  int weekNumber;
  String isPlayed;

  Event(
      {
      //   this.id,
      // this.date,
      this.childTag,
      this.field,
      this.playNumber,
      this.weekNumber,
      // this.datePlayed
      });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      // 'date': date,
      'childTag': childTag,
      'field': field,
      'playNumber': playNumber,
      'weekNumber': weekNumber,
      'isPlayed': isPlayed,
    };
  }

  @override
  String toString() {
    return 'Event{childTag: $childTag, field: $field, playNumber: $playNumber, weekNumber: $weekNumber, isPlayed: $isPlayed}';
  }

}

// List<Event> eventModelList = [
//   Event(
//       id: 1,
//       date: '2020-05-06',
//       childTag: 'CHILDINDEX0',
//       field: 'sociality',
//       playNumber: 1,
//       weekNumber: 2,
//       datePlayed: 'false'),
//   Event(
//       id: 2,
//       date: '2020-05-06',
//       childTag: 'CHILDINDEX0',
//       field: 'selfEsteem',
//       playNumber: 1,
//       weekNumber: 2,
//       datePlayed: 'false'),
//   Event(
//       id: 3,
//       date: '2020-05-06',
//       childTag: 'CHILDINDEX0',
//       field: 'creativity',
//       playNumber: 1,
//       weekNumber: 2,
//       datePlayed: 'false'),
//   Event(
//       id: 4,
//       date: '2020-05-06',
//       childTag: 'CHILDINDEX0',
//       field: 'happiness',
//       playNumber: 1,
//       weekNumber: 2,
//       datePlayed: 'false'),
//   Event(
//       id: 5,
//       date: '2020-05-06',
//       childTag: 'CHILDINDEX0',
//       field: 'science',
//       playNumber: 1,
//       weekNumber: 2,
//       datePlayed: 'false'),
// ];
