class Category {
  int id;
  String name;
  String image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

class Categories {
  final List<dynamic> catList;

  Categories({this.catList});

  factory Categories.fromjson(List<dynamic> jsonData) {
    return Categories(
      catList: jsonData,
    );
  }
}
