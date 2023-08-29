/// User Info entity
class SkillHunterUserInfo {
  SkillHunterUserInfo({
    required this.userId,
    required this.fullName,
    required this.email,
  });

  /// converts authentication response form json to an authentication response instance
  factory SkillHunterUserInfo.fromJson(Map<String, dynamic> json) => SkillHunterUserInfo(
        userId: json['user_id'] as String?,
        fullName: json['full_name'] as String?,
        email: json['email'] as String?,
      );
  SkillHunterUserInfo copyWith({String? userId, String? fullName, String? email}) {
    return SkillHunterUserInfo(
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }

  /// user id
  final String? userId;

  /// user name
  final String? fullName;

  /// user's email
  final String? email;

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'email': email,
      };
}
