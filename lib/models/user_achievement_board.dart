class UserAchievementBoard {
  dynamic total_practice_second;
  dynamic number_true_answer;
  dynamic number_false_answer;
  UserAchievementBoard({
    required this.total_practice_second,
    required this.number_true_answer,
    required this.number_false_answer,
  });
  Map<String, dynamic> toJson() => {
        'total_practice_second': total_practice_second,
        'number_true_answer': number_true_answer,
        'number_false_answer': number_false_answer,
      };
  static UserAchievementBoard fromJson(Map<String, dynamic> json) => UserAchievementBoard(
        total_practice_second: json['total_practice_second'],
        number_true_answer: json['number_true_answer'],
        number_false_answer: json['number_false_answer'],
      );
}