class UserWorkDone {
  final String TimeDay;
  final String Subject;
  final String Time;
  final int FalseAnwer;
  final int TrueAnswer;
  final int NumberAnswer;
  final int TotalTime;
  final List<String?> listAnswer;
  final List<String?> ListQuestion;
  final List<String?> ListTrueAnswer;
  final dynamic TimeID;
  UserWorkDone({
    required this.TimeID,
    required this.TotalTime,
    required this.TimeDay,
    required this.Subject,
    required this.Time,
    required this.FalseAnwer,
    required this.TrueAnswer,
    required this.NumberAnswer,
    required this.listAnswer,
    required this.ListQuestion,
    required this.ListTrueAnswer,
  });
  Map<String, dynamic> toJson() => {
        'TimeDay': TimeDay,
        'Subject': Subject,
        'Time': Time,
        'FalseAnwer': FalseAnwer,
        'TrueAnswer': TrueAnswer,
        'NumberAnswer': NumberAnswer,
        'TotalTime': TotalTime,
        'TimeID': TimeID,
        'ListQuestion': ListQuestion,
        'ListTrueAnswer': ListTrueAnswer,
        'listAnswer': listAnswer
      };
  static UserWorkDone fromJson(Map<String, dynamic> json) => UserWorkDone(
      TimeDay: json['TimeDay'],
      Subject: json['Subject'],
      Time: json['Time'],
      FalseAnwer: json['FalseAnwer'],
      TrueAnswer: json['TrueAnswer'],
      NumberAnswer: json['NumberAnswer'],
      listAnswer: json['listAnswer'],
      TotalTime: json['TotalTime'],
      TimeID: json['TimeID'],
      ListQuestion: json['ListQuestion'],
      ListTrueAnswer: json['ListTrueAnswer']);
}