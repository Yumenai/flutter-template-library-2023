import 'user_profile_model.dart';

class UserSetupModel {
  static UserSetupModel? fromJson(final Map? json) {
    if (json == null) return null;

    return UserSetupModel(
      sessionAccessToken: json['session_access_token']?.toString() ?? '',
      profileModel: UserProfileModel.fromJson(json['profile']),
    );
  }

  final String sessionAccessToken;
  final UserProfileModel? profileModel;

  const UserSetupModel({
    required this.sessionAccessToken,
    required this.profileModel,
  });
}
