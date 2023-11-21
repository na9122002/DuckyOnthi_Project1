import 'dart:convert';

import 'package:travo_app_source/EnglishClassUnivercity/question_model.dart';

List<Question_Model> getListModelStory(String respon) {
  var list_question = json.decode(respon) as List<dynamic>;
  List<Question_Model> models =
      list_question.map((model) => Question_Model.fromJson(model)).toList();
  return models;
}
