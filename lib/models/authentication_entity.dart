/// Login request data
class LoginRequestData {
  /// Login request data constructor
  const LoginRequestData({required this.email, required this.password});

  ///
  final String email;

  ///
  final String password;

  ///
  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

/// Registration request data
class RegistrationRequestData extends LoginRequestData {
  /// Registration request data constructor
  const RegistrationRequestData({
    required super.email,
    required super.password,
    required this.fullName,
  });

  ///
  final String fullName;

  ///
  @override
  Map<String, dynamic> toJson() => {
        'role': 'USER',
        'email': email,
        'full_name': fullName,
        'verified': false,
      };
}
