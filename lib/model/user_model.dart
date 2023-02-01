class UserModel {
  static UserModel? fromNetworkRepository(final Map? dataMap) {
    if (dataMap == null) return null;

    return UserModel(
      id: dataMap['id']?.toString() ?? '',
      name: dataMap['name']?.toString() ?? '',
    );
  }

  final String id;
  final String name;

  const UserModel({
    required this.id,
    required this.name,
  });
}
