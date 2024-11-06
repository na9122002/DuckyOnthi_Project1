class ItemModel {
  dynamic? _id;
  dynamic? id;
  dynamic? question;
  dynamic? trueAnwer;
  dynamic? falseAnwer1;
  dynamic? falseAnwer2;
  dynamic? falseAnwer3;
  
  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _id = parsedJson['_id'] ;
    id = parsedJson['id'];
    question = parsedJson['question'];
    trueAnwer = parsedJson['trueAnswer'];
    falseAnwer1 = parsedJson['falseAnswer1'];
    falseAnwer2 = parsedJson['falseAnwser2'];
    falseAnwer3 = parsedJson['falseAnwer3'];
  }

}




// class ItemModel {
//   String? id; // Renamed _id to idPrivate to avoid using underscore
//   String? question;
//   String? trueAnswer;  // Fixed typo: trueAnwer -> trueAnswer
//   String? falseAnswer1; // Fixed typo: falseAnwer1 -> falseAnswer1
//   String? falseAnswer2; // Fixed typo: falseAnwer2 -> falseAnswer2
//   String? falseAnswer3; // Fixed typo: falseAnwer3 -> falseAnswer3
  
//   // Constructor with named parameters
//   ItemModel({
//     this.id,
//     this.question,
//     this.trueAnswer,
//     this.falseAnswer1,
//     this.falseAnswer2,
//     this.falseAnswer3,
//   });

//   // Named constructor for creating an instance from JSON
//   ItemModel.fromJson(Map<String, dynamic> parsedJson) {
//     id = parsedJson['_id'];
//     question = parsedJson['question'];
//     trueAnswer = parsedJson['trueAnswer'];
//     falseAnswer1 = parsedJson['falseAnswer1'];
//     falseAnswer2 = parsedJson['falseAnswer2'];
//     falseAnswer3 = parsedJson['falseAnswer3'];
//   }

//   // Method to convert the object back to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'question': question,
//       'trueAnswer': trueAnswer,
//       'falseAnswer1': falseAnswer1,
//       'falseAnswer2': falseAnswer2,
//       'falseAnswer3': falseAnswer3,
//     };
//   }
// }