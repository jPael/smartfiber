import 'dart:convert';

import 'package:smartfiber/models/prediction.dart';
import 'package:smartfiber/services/laravel/api_url_base.dart';

import 'package:http/http.dart' as http;

Future<Prediction> getImagePrediction(int id) async {
  final url = apiURIBase.replace(path: LaravelPaths.predict);

  final res = await http.post(url, body: {'user_id': id.toString()});

  final data = jsonDecode(res.body);

  return Prediction(
      grade: data['randomItem']['grade'],
      localName: data['randomItem']['local_name'],
      price: data['randomItem']['price'],
      date: DateTime.parse(data['date']));
}
