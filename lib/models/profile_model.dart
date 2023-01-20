import 'dart:convert';

class ProfileModel {
  String id; // Firebase Auth UID
  String name;
  String email;
  DateTime registeredAt;
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.registeredAt,
  });

  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? registeredAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      registeredAt: registeredAt ?? this.registeredAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'registeredAt': registeredAt.millisecondsSinceEpoch});

    return result;
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      registeredAt: DateTime.fromMillisecondsSinceEpoch(map['registeredAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, email: $email, registeredAt: $registeredAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.registeredAt == registeredAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ registeredAt.hashCode;
  }
}
