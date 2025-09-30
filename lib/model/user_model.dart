class User {
  final int? id;
  final String? name;
  final String? email;
  final String? username;
  final String? phone;
  final String? website;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.username,
    this.website,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      email: json['email'],
      username: json['username'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}
