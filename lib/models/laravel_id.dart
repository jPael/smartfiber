import 'package:flutter/foundation.dart';

class LaravelId with ChangeNotifier {
  int? id;

  bool isLoading = false;

  void setId(int _id) {
    id = _id;
    notifyListeners();
  }

  void setIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
