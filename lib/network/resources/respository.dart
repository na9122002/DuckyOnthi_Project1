
import 'package:travo_app_source/network/models_api/item_api_model.dart';
import 'package:travo_app_source/network/resources/question_api_provider.dart';
class Respository {
  Future<List<ItemModel>> fetchAllQuestion() => QuestionApiProvider().fetchQuestionList();
  Future<List<ItemModel>> fetchAllQuestionChemictry() => QuestionApiProvider().fetchQuestionChemictryList();
  Future<List<ItemModel>> fetchAllQuestionBiology() => QuestionApiProvider().fetchQuestionBiologyList();
}