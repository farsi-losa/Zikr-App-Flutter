// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:dzikirapp/db.dart';
import 'package:flutter/foundation.dart';
// import 'package:provider_shopper/models/catalog.dart';

class SettingsModel extends ChangeNotifier {
  late bool _dzikirReference = true;
  final DatabaseHandler handler = DatabaseHandler();

  void setDzikirReference(bool value) {
    _dzikirReference = value;
    notifyListeners();
  }

  void initDzikirReference(bool value) {
    final address =
        this.handler.retrieveSettingsByCode('dzikir_default').then((data) {
      print(data);
      _dzikirReference = data.active == 1;

      return data.active == 1;
    }, onError: (e) {
      print(e);
    });
    print(address);
    notifyListeners();
  }

  get dzikirReference => _dzikirReference;

  Future<bool> get fetchSetting {
    final address =
        this.handler.retrieveSettingsByCode('dzikir_default').then((data) {
      print(data);
      _dzikirReference = data.active == 1;

      return data.active == 1;
    }, onError: (e) {
      print(e);
    });
    print(address);
    return address;
  }
}
