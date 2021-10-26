import 'package:get_it/get_it.dart';

import '../provider/api_provider.dart';

abstract class BaseApiService {
  ApiProvider get provider => GetIt.I<ApiProvider>();
}
