class HeartListModel {
  final List<HeartItemModel>? items;

  HeartListModel({this.items});

  factory HeartListModel.fromMap(List<Map<String, dynamic>> maps) =>
      HeartListModel(
        items: List<HeartItemModel>.from(maps),
      );
}

class HeartItemModel {
  final String? name;
  final int? age;
  final String? path;
  final String? desc;

  HeartItemModel({this.name, this.age, this.path, this.desc});

  factory HeartItemModel.fromMap(Map<String, dynamic> map) => HeartItemModel(
        name: map['name'],
        age: map['age'],
        path: map['path'],
        desc: map['desc'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'age': age,
        'path': path,
        'desc': desc,
      };
}
