class HeartListModel {
  final List<HeartItemModel>? items;

  HeartListModel({this.items});

  factory HeartListModel.fromMap(List<Map<String, dynamic>> maps) {
    return HeartListModel(
        items: List<HeartItemModel>.generate(
            maps.length, (index) => HeartItemModel.fromMap(maps[index])));
  }
}

class HeartItemModel {
  final int? id;
  final String? name;
  final int? age;
  final String? path;
  final String? desc;

  HeartItemModel({this.id,this.name, this.age, this.path, this.desc});

  factory HeartItemModel.fromMap(Map<String, dynamic> map) => HeartItemModel(
        id: map['id'],
        name: map['name'],
        age: int.parse(map['age']),
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
