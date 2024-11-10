class UserQuestion {
  final String IDUser;
  final String content;
  final List<String> image;
  final String time;
  final String userName;
  final String ShowTime;
  UserQuestion(
      {required this.IDUser,
      required this.content,
      required this.image,
      required this.time,
      required this.userName,
      required this.ShowTime});
  Map<String, dynamic> toJson() => {
        'IDUser': IDUser,
        'content': content,
        'image': image,
        'time': time,
        'userName': userName,
        'ShowTime': ShowTime
      };
  static UserQuestion fromJson(Map<String, dynamic> json) => UserQuestion(
      IDUser: json['IDUser'],
      content: json['content'],
      image: json['image'],
      time: json['time'],
      userName: json['userName'],
      ShowTime: json['ShowTime']);
}