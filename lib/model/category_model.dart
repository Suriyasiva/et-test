import 'dart:convert';

class CategoryModel {
  final String userId;
  final String category;
  final bool active;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.userId,
    required this.category,
    required this.id,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryModel copyWith({
    String? userId,
    String? category,
    bool? active,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      userId: userId ?? this.userId,
      category: category ?? this.category,
      active: active ?? this.active,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': userId,
      'lastName': category,
      'id': id,
      'active': active,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    try {
      return CategoryModel(
        userId: map['userId'] ?? '',
        id: map['id']?.toInt() ?? 0,
        category: map['category'] ?? '',
        active: map['active'] ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel(id: $id, userId: $userId, category: $category, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel &&
        other.id == id &&
        other.userId == userId &&
        other.category == category &&
        other.active == active &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        id.hashCode ^
        category.hashCode ^
        active.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
