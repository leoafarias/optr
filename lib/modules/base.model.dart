/// Password Types
enum PasswordType {
  /// Type of Account Password
  accountPassword,

  /// Type of Master Secret
  masterSecret
}

/// Base Model Class
abstract class BaseModel {
  /// Unique Identifier of Base Model
  final String id;

  /// Converts values to JSON
  String toJson();

  /// Converts values to Map
  Map<String, dynamic> toMap();

  /// Constructor
  BaseModel({this.id});

  /// Validates model
  bool validate();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseModel &&
          runtimeType == other.runtimeType &&
          toJson() == other.toJson();

  @override
  int get hashCode => toJson().hashCode;
}
