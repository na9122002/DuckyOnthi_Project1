class TaskScheledu {
  final String title;
  final String note;
  final String startTime;
  final String endTime;
  final String remind;
  final String Time;

  TaskScheledu({
    required this.title,
    required this.note,
    required this.startTime,
    required this.endTime,
    required this.remind,
    required this.Time,
  });
  Map<String, dynamic> toJson() => {
        'title': title,
        'note': note,
        'startTime': startTime,
        'endTime': endTime,
        'remind': remind,
        'Time': Time,
      };

  static TaskScheledu fromJson(Map<String, dynamic> json) => TaskScheledu(
      title: json['title'],
      note: json['note'],
      Time: json['time'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      remind: json['remind']);
}
