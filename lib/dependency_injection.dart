import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/env.dart';
import 'core/preference_store/hive_preference_store.dart';
import 'core/preference_store/preference_store.dart';
import 'core/utils/simple_bloc_delegate.dart';
import 'data/local/hive_repository.dart';
import 'data/local/local_repository.dart';
import 'data/remote/provider/api_provider.dart';
import 'data/remote/provider/providers/dio_api_provider.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.I;

  static Future<void> setUp<T>(Env env) async {
    WidgetsFlutterBinding.ensureInitialized();
    // initialize hive database
    await Hive.initFlutter();

    /// give bloc library an observer delegate
    Bloc.observer = SimpleBlocDelegate();

    /// register the current environment the app is running on
    getIt.registerSingleton<Env>(env);

    /// initialize app with a preference store used for local storage
    getIt.registerSingletonAsync<PreferenceStore>(() async {
      var pref = HivePreferenceStore();
      await pref.initStore();
      return pref;
    });

    /// add implementation of local repository to be used by the data repository for caching data
    getIt.registerSingletonAsync<LocalRepository>(() async {
      var pref = HiveRepository();
      await pref.init();
      return pref;
    });

    /// add implementation of api provider to be used by the data repository for fetching remote data
    getIt.registerSingleton<ApiProvider>(DioApiProvider());

    await GetIt.instance.allReady();
  }
}
