import 'package:flutter/material.dart';
import 'package:flutter_state_sample/model/language.dart';

class GitHubTrendModel extends ChangeNotifier {
  Language language;

  void changeLanguage(Language language) {
    this.language = language;
    notifyListeners();
  }
}
