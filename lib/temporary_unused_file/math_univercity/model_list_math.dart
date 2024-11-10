import 'dart:convert';

import 'package:travo_app_source/math_univercity/question_model_math.dart';

List<Question_Model1> getListModelStory1(String respon) {
  var list_question = json.decode(respon) as List<dynamic>;
  List<Question_Model1> models =
      list_question.map((model) => Question_Model1.fromJson(model)).toList();
  return models;
}
