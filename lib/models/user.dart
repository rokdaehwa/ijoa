class User {
  String name;
  String birthday;
  String momOrDad;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        birthday = json['birthday'],
        momOrDad = json['momOrDad'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'birthday': birthday,
        'momOrDad': momOrDad,
      };

  int getAge() {
    if (this.birthday == null) return 0;
    List<int> _birth =
        this.birthday.split('-').map((e) => int.parse(e)).toList();
    DateTime _birthInDateTime = DateTime.utc(_birth[0], _birth[1], _birth[2]);
    Duration _diff = DateTime.now().difference(_birthInDateTime);
    return (_diff.inDays / 365).floor();
  }

  @override
  String toString() {
    return "{name: $name, birthday: $birthday, momOrDad: $momOrDad}";
  }
}
