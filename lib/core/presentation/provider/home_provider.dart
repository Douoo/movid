import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';

class HomeProvider extends ChangeNotifier {
  ContentType _content = ContentType.movie;

  ContentType get contentType => _content;

  void setContentType(ContentType type) {
    _content = type;
    notifyListeners();
  }
}
