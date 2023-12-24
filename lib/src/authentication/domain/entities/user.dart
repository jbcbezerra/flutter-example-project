class User {
  final int id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User && runtimeType == other.runtimeType && id == other.id &&
              createdAt == other.createdAt && name == other.name &&
              avatar == other.avatar;

  @override
  int get hashCode =>
      id.hashCode ^ createdAt.hashCode ^ name.hashCode ^ avatar.hashCode;

}
