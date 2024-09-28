class Question_Model1 {
  dynamic id;
  dynamic question;
  dynamic image;
  dynamic trueAnswer;
  dynamic falseAnwer1;
  dynamic falseAnwer2;
  dynamic falseAnwer3;
  Question_Model1(
      {this.id,
      this.question,
      this.image,
      this.trueAnswer,
      this.falseAnwer1,
      this.falseAnwer2,
      this.falseAnwer3});
  Question_Model1.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    question = json['question'];
    image = json['image'];
    trueAnswer = json['trueAnswer'];
    falseAnwer1 = json['falseAnswer1'];
    falseAnwer2 = json['falseAnwser2'];
    falseAnwer3 = json['falseAnwer3'];
  }
  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    data['image'] = this.image;
    data['trueAnswer'] = this.trueAnswer;
    data['falseAnwer1'] = this.falseAnwer1;
    data['falseAnwer2'] = this.falseAnwer2;
    data['falseAnwer3'] = this.falseAnwer3;

    return data;
  }
}
