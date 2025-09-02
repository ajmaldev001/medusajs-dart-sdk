import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

/// Represents a product collection in the Medusa system
@JsonSerializable(fieldRename: FieldRename.snake)
class Collection {
  /// Unique identifier for the collection
  final String id;

  /// Collection title
  final String title;

  /// Collection handle (URL slug)
  final String? handle;

  /// Timestamp of creation
  final DateTime? createdAt;

  /// Timestamp of last update
  final DateTime? updatedAt;

  /// Timestamp of deletion (soft delete)
  final DateTime? deletedAt;

  /// Metadata associated with the collection
  final Map<String, dynamic>? metadata;

  const Collection({
    required this.id,
    required this.title,
    this.handle,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.metadata,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Collection && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Collection(id: $id, title: $title)';
}
