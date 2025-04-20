import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smartfiber/error/app_error.dart';
import 'package:smartfiber/fields/user_fields.dart';
import 'package:smartfiber/models/new_user.dart';
import 'package:smartfiber/models/recent.dart';
import 'package:smartfiber/services/laravel/api_url_base.dart';
import 'package:smartfiber/services/laravel/fields.dart';
import 'package:smartfiber/utils/const_utils.dart';
// import 'package:smartfiber/services/laravel/api_url.dart';
// import 'package:smartfiber/services/laravel/fields.dart';
import 'package:smartfiber/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> registerAccount({
  required String name,
  required String email,
  required String password,
  required UserType type,
  required String phoneNumber,
  required String barangay,
  required String username,
}) async {
  Map<String, dynamic> body = {
    RegistrationFields.name: name,
    // RegistrationFields.email: email,
    RegistrationFields.password: password,
    // RegistrationFields.passwordConfirmation: password,
    RegistrationFields.phone: phoneNumber,
    RegistrationFields.barangay: "example barangay",
    RegistrationFields.username: username,
    // RegistrationFields.barangayId: "1",
    // RegistrationFields.userType: getIntegerFromUserTypeEnum(type),
  };

  log(body.toString());

  final url = apiURIBase.replace(path: LaravelPaths.register);

  final res = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  log(res.body);
  log(res.statusCode.toString());
  log((res.statusCode == HttpStatus.ok).toString());

  final data = jsonDecode(res.body);

  final message = data[RegistrationResponseJsonProperties.message];

  if (data[RegistrationResponseJsonProperties.errors] != null) {
    throw Exception(message);
  }

  return;
}

Future<int?> loginAccount({required String username, required String password}) async {
  final url = apiURIBase.replace(path: LaravelPaths.login);

  try {
    final res = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": username, "password": password}));

    log({"username": username, "password": password}.toString());
    log(res.body.toString());
    final data = jsonDecode(res.body);

    if (data["error"] != null) {
      throw Exception(errorMessage(data["message"]));
    }

    // log(data["data"]["user"]["id"].toString());

    return data["data"]["user"]["id"];
  } catch (e, stackTrace) {
    log("There was an error: e", stackTrace: stackTrace);
    return null;
  }
  // return {
  //   // UserFields.token: data["data"]["token"],
  //   UserFields.laravelId: data["data"]["user"]["id"],
  // };
}

Future<void> logoutAccount({required String token}) async {
  // final url = apiURIBase.replace(path: LaravelPaths.logout);

  // final res = await http
  //     .post(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

  // log(res.body);
}

Future<List<Recent>> fetchRecentByUserId(int id) async {
  final url = apiURIBase.replace(path: LaravelPaths.recentsById(id));

  final res = await http.get(url);

  log(res.body);

  final List<dynamic> data = jsonDecode(res.body);

  return data.map((d) => Recent.fromJson(d)).toList();
}

// Future<Map<String, dynamic>> fetchUserByToken(String token) async {
//   // final url = apiURIBase.replace(path: LaravelPaths.user);

//   // final res = await http
//   //     .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

//   // return jsonDecode(res.body) as Map<String, dynamic>;
// }

// Future<Map<String, dynamic>> fetchUserByUserId({required int id, required String token}) async {
//   // final url = apiURIBase.replace(path: "${LaravelPaths.user}/$id");

//   // final res = await http
//   //     .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

//   // return jsonDecode(res.body) as Map<String, dynamic>;
// }
