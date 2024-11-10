
class QuestionAndComment {
  final String comment;
  final String image;
  final String time;
  final String userName;
  final String IDuser;
  final String ShowTime;

  QuestionAndComment.QuestionAndComment({
    required this.comment,
    required this.image,
    required this.time,
    required this.userName,
    required this.IDuser,
    required this.ShowTime,
  });
  Map<String, dynamic> toJson() => {
        'comment': comment,
        'image': image,
        'time': time,
        'userName': userName,
        'IDuser': IDuser,
        'ShowTime': ShowTime
      };

  static QuestionAndComment fromJson(Map<String, dynamic> json) => QuestionAndComment.QuestionAndComment(
      comment: json['comment'],
      image: json['image'],
      time: json['time'],
      userName: json['userName'],
      IDuser: json['IDuser'],
      ShowTime: json['ShowTime']);
}