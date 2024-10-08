import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:travo_app_source/network/models_api/item_api_model.dart';

class QuestionApiProvider {
  final Client client = Client();

  Future<List<ItemModel>> fetchQuestionList() async {
    final response = await client.get(Uri.parse('http://45.122.253.163:3000/question/listMaHocSinh?maHocSinh=A02103&monHoc=tiengAnh'));
print('nnnnn:${response.body.toString()}');
    if (response.statusCode == 200) {
      

      // Decode the response body as a JSON list
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

      // Convert each JSON object in the list to an ItemModel
      final List<ItemModel> listItem = jsonList.map((json) => ItemModel.fromJson(json)).toList();

      return listItem;
    } else {
      throw Exception('Failed to load post');
    }
  }
  Future<List<ItemModel>> fetchQuestionChemictryList() async {
    final response = await client.get(Uri.parse('http://45.122.253.163:3000/question/listMaHocSinh?maHocSinh=A02103&monHoc=hoaHoc'));

    if (response.statusCode == 200) {
      print(response.body);

      // Decode the response body as a JSON list
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

      // Convert each JSON object in the list to an ItemModel
      final List<ItemModel> listItem = jsonList.map((json) => ItemModel.fromJson(json)).toList();

      return listItem;
    } else {
      throw Exception('Failed to load post');
    }
  }

   Future<List<ItemModel>> fetchQuestionBiologyList() async {
    final response = await client.get(Uri.parse('http://45.122.253.163:3000/question/listMaHocSinh?maHocSinh=A02103&monHoc=sinhHoc'));

    if (response.statusCode == 200) {
      print(response.body);

      // Decode the response body as a JSON list
      final List<dynamic> jsonList = json.decode(utf8.decode(response.bodyBytes));

      // Convert each JSON object in the list to an ItemModel
      final List<ItemModel> listItem = jsonList.map((json) => ItemModel.fromJson(json)).toList();

      return listItem;
    } else {
      throw Exception('Failed to load post');
    }
  }

}
