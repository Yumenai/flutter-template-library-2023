class UserProfileModel {
  static UserProfileModel? fromJson(final Map? json) {
    if (json == null) return null;

    return UserProfileModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      birthdate: DateTime.tryParse(json['birthdate']?.toString() ?? ''),
    );
  }

  final String id;
  final String name;
  final String email;
  final DateTime? birthdate;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.birthdate,
  });
}
