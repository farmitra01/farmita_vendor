class PostLoginRequest {
  final String email;
  final String password;

  PostLoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory PostLoginRequest.fromJson(Map<String, dynamic> json) {
    return PostLoginRequest(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }
}