class Event {
  final int id;
  final String date;
  final String childTag;
  final String field;
  final String subField;
  final int playNumber;
  final int weekNumber;
  final bool isPlayed;

  Event({this.id, this.date, this.childTag, this.field, this.subField, this.playNumber, this.weekNumber, this.isPlayed});



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'childTag': childTag,
      'field': field,
      'subField': subField,
      'playNumber': playNumber,
      'weekNumber': weekNumber,
      'isPlayed':  isPlayed,
    };
  }

  @override
  String toString() {
    return 'Event{id: $id, date: $date, childTag: $childTag, field: $field, subField: $subField, playNumber: $playNumber, weekNumber: $weekNumber, isPlayed: $isPlayed}';
  }
  
  // void setIsPlayed(bool value) {
  //   isPlayed = value;
  // }
}

List<Event> eventModelList = [
  Event(id: 1, date: '2020-05-06', childTag: '기상이', field: 'sociality', subField: '협동적 조형활동', playNumber: 1, weekNumber: 2, isPlayed: false),
];