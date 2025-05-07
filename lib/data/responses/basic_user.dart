class BasicUser {
  final String id;
  final String name;
  final String email;
  final String role;

  BasicUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory BasicUser.fromJson(Map<String, dynamic> json) {
    return BasicUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}