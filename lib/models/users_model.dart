class User {
  String id;
  final String TenDangNhap;
  final String Sodienthoai;
  final String email;
  final String MatKhau;
  User({
    this.id = '',
    required this.TenDangNhap,
    required this.Sodienthoai,
    required this.email,
    required this.MatKhau,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'TenDangNhap': TenDangNhap,
        'Sodienthoai': Sodienthoai,
        'email': email,
        'Matkhau': MatKhau,
      };

  static User fromJson(Map<String, dynamic> json) => User(
      id: json['id'],
      TenDangNhap: json['TenDangNhap'],
      Sodienthoai: json['Sodienthoai'],
      email: json['email'],
      MatKhau: json['Matkhau']);
}