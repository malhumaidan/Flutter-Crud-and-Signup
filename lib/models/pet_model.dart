import 'dart:convert';

class Pet {
  int id;
  String name;
  bool adopted;
  String image;
  int age;
  String gender;

  Pet({
    required this.id,
    required this.name,
    required this.adopted,
    required this.image,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'adopted': adopted,
      'image': image,
      'age': age,
      'gender': gender,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      adopted: map['adopted'] ?? false,
      image: map['image'] ?? '',
      age: map['age']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Pet.fromJson(String source) => Pet.fromMap(json.decode(source));
}
