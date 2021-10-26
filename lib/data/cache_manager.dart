///Ekeh Wisdom ekeh.wisdom@gmail.com
///c2019
///Sun Nov 24 2019
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class CacheManager {
  Future<dynamic> getCachedData(String path) async {
    Directory tempDir = await getTemporaryDirectory();
    try {
      // if(path.startsWith('/')) path = path.replaceFirst('/', '');
      path = path.split('/').last;
      if (kDebugMode) print('get cache.....$path.');
      bool isFound = await File('${tempDir.path}/$path.json').exists();
      if (kDebugMode) print('check temp finished $isFound');
      if (isFound) {
        String s = await File('${tempDir.path}/$path.json').readAsString();
        if (kDebugMode) print('cache.....$path.');
        return s;
      } else
        return null;
    } catch (e) {
      return null;
    }
  }

  Future<bool> savToCache(String path, String data) async {
    Directory tempDir = await getTemporaryDirectory();
    try {
      path = path.split('/').last;
      if (kDebugMode) print('save to cache.....$path. $data');

      await File('${tempDir.path}/$path.json').writeAsString(data);
      return true;
    } catch (e) {
      if (kDebugMode) print(e);
      return false;
    }
  }
}
