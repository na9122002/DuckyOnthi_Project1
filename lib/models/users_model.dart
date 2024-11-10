
class User {
  String id;
  final String username;
  final String mobile;
  final String email;
  final String password;
  User({
    this.id = '',
    required this.username,
    required this.mobile,
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'mobile': mobile,
        'email': email,
        'password': password,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      username: json['username'],
      mobile: json['mobile'],
      email: json['email'],
      password: json['password']);
}