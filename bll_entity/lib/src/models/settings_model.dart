import 'package:flutter/foundation.dart';

import '../../entity.dart';

class SettingsModel extends ChangeNotifier {
  ViewSettings _viewSettings = ViewSettings.fromJson(Map());

  void set(Map<String, dynamic> json) {
    _viewSettings = ViewSettings.fromJson(json);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  ViewSettings getViewSettings() {
    return _viewSettings;
  }
}
