class Child {
  String name;
  String birthday;
  String gender;
  // String lastTested;
  // String lastPlayed;

  Child.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        birthday = json['birthday'],
        gender = json['gender'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'birthday': birthday,
    'gender': gender
  };

  @override
  String toString() {
    return '{name: $name, birthday: $birthday, gender: $gender}';
  }
}