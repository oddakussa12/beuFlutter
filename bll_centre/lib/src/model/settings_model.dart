import 'package:common/common.dart';
import 'package:flutter/foundation.dart';

import '../centre_config.dart';

class SettingsModel extends ChangeNotifier {
  String? _retrivedJSON = null;
  ViewSettings _viewSettings = ViewSettings.fromJson(Map());

  void set(Map<String, dynamic> json) {
    _viewSettings = ViewSettings.fromJson(json);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  ViewSettings getViewSettings() {
    if (_retrivedJSON == null) {
      _retrivedJSON = _viewSettings.toJson().toString();
      String url = CentreUrl.settings;

      DioClient().get(url, (response) => ViewSettings.fromJson(response.data),
          success: (ViewSettings data) {
            _viewSettings = data;
            _retrivedJSON = data.toJson().toString();
            notifyListeners();
          },
          complete: () {},
          fail: (arg, e) {
            LogDog.d(e);
          });
    }

    return _viewSettings;
  }
}
