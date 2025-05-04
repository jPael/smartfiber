import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:smartfiber/models/prediction.dart';
import 'package:smartfiber/services/laravel/api_url_base.dart';

Future<Prediction?> getImagePrediction({
  required int userId,
  required File imageFile,
}) async {
  final url = apiURIBase.replace(path: LaravelPaths.predict);

  try {
    // Create multipart request
    final request = http.MultipartRequest('POST', url);

    // Add user ID field
    request.fields['user_id'] = userId.toString();

    // Get MIME type and validate it's an image
    final mimeType = lookupMimeType(imageFile.path);
    if (mimeType == null || !mimeType.startsWith('image/')) {
      throw Exception('Invalid image file type');
    }

    // Add image file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType.parse(mimeType),
    ));

    // Send the request
    final response = await request.send();

    // Process the response
    if (response.statusCode == HttpStatus.ok) {
      final responseData = await response.stream.bytesToString();
      // log(responseData);

      final jsonRes = jsonDecode(responseData) as Map<String, dynamic>;

      return Prediction(
        grade: jsonRes['randomItem']['grade'],
        localName: jsonRes['randomItem']['local_name'],
        price: jsonRes['randomItem']['price'],
        date: DateTime.parse(jsonRes['date']),
      );
    } else {
      final errorData = await response.stream.bytesToString();
      log('Prediction API error: ${response.statusCode}',
          error: errorData, stackTrace: StackTrace.current);
      return null;
    }
  } catch (e, stackTrace) {
    log('Prediction API exception', error: e, stackTrace: stackTrace);
    return null;
  }
}
