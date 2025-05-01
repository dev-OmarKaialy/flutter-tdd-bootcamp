import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'dependencies.config.dart';

final di = GetIt.instance;
@InjectableInit(
    initializerName: 'initGetIt',
    preferRelativeImports: true,
    asExtension: true)
void configureDependecy() => di.initGetIt();
