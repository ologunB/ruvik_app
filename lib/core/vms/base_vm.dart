import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/navigator.dart';

export 'package:provider/provider.dart';

export '../../locator.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    if (hasListeners) notifyListeners();
  }

  log(dynamic data) {
    Logger l = Logger();
    l.d(data);
  }

  BuildContext get vmContext => AppNavigator.navKey.currentContext!;
}
