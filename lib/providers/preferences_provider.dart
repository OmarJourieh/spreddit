import 'package:flutter/material.dart';

enum Languages { en, ar }

class PreferencesProvider extends ChangeNotifier {
  var language = Languages.en;
}
