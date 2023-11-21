class Question_Model {
  String? id;
  String? question;
  String? trueAnswer;
  String? falseAnwer1;
  String? falseAnwer2;
  String? falseAnwer3;
  Question_Model(
      {this.id,
      this.question,
      this.trueAnswer,
      this.falseAnwer1,
      this.falseAnwer2,
      this.falseAnwer3});
  Question_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    trueAnswer = json['trueAnswer'];
    falseAnwer1 = json['falseAnswer1'];
    falseAnwer2 = json['falseAnwser2'];
    falseAnwer3 = json['falseAnwer3'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['trueAnswer'] = this.trueAnswer;
    data['falseAnwer1'] = this.falseAnwer1;
    data['falseAnwer2'] = this.falseAnwer2;
    data['falseAnwer3'] = this.falseAnwer3;
    return data;
  }
}
