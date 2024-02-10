import 'dart:convert';

class ExpenseModel {
  final String category;
  final String description;
  final String amount;
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;

  ExpenseModel({
    required this.category,
    required this.description,
    required this.id,
    required this.amount,
    required this.createdAt,
    required this.updatedAt,
  });

  ExpenseModel copyWith({
    String? category,
    String? description,
    String? amount,
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ExpenseModel(
      category: category ?? this.category,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': description,
      'lastName': category,
      'id': id,
      'active': amount,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    try {
      return ExpenseModel(
        description: map['description'] ?? '',
        id: map['id']?.toInt() ?? 0,
        category: map['category'] ?? '',
        amount: map['amount'] ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());

  factory ExpenseModel.fromJson(String source) =>
      ExpenseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpenseModel(id: $id, description: $description, category: $category, amount: $amount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpenseModel &&
        other.id == id &&
        other.description == description &&
        other.category == category &&
        other.amount == amount &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        id.hashCode ^
        category.hashCode ^
        amount.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
