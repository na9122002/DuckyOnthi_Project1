
import 'package:rxdart/rxdart.dart';
import 'package:travo_app_source/network/models_api/item_api_model.dart';
import 'package:travo_app_source/network/resources/respository.dart';
class QuestionBloc {
  final QuestionFetcher = PublishSubject<List<ItemModel>>();
  final QuestionChemictryFetcher = PublishSubject<List<ItemModel>>();
  final QuestionBiologyFetcher = PublishSubject<List<ItemModel>>();
   Stream<List<ItemModel>> get allQuestion => QuestionFetcher.stream;
  fetchAllQuestion() async {
    final repository = Respository();
    List<ItemModel> itemModel = await repository.fetchAllQuestion();
    QuestionFetcher.sink.add(itemModel);
  }
  Stream<List<ItemModel>> get allChemictryQuestion => QuestionChemictryFetcher.stream;
  fetchAllChemictryQuestion() async {
    final repository = Respository();
    List<ItemModel> itemChemictryModel = await repository.fetchAllQuestionChemictry();
    QuestionChemictryFetcher.sink.add(itemChemictryModel);
  }
  Stream<List<ItemModel>> get allBiologyQuestion => QuestionBiologyFetcher.stream;
  fetchAllBiologyQuestion() async {
    final repository = Respository();
    List<ItemModel> itemBiologyModel = await repository.fetchAllQuestionBiology();
    QuestionBiologyFetcher.sink.add(itemBiologyModel);
  }
  dispose() {
    QuestionFetcher.close();
    QuestionChemictryFetcher.close();
    QuestionBiologyFetcher.close();
  }
}

