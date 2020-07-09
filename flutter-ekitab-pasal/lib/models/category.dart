class BookCategory {
  int id;
  String name;
  String icon;

  BookCategory({this.id, this.name, this.icon});

  factory BookCategory.fromJson(Map<String, dynamic> json) {
    return BookCategory(
      id: json['id'],
      name: json['name'],
      icon: json['image'],
    );
  }
}
