import 'package:catcher/catcher.dart';
import 'package:chaldea/app/chaldea_next.dart';
import 'package:chaldea/components/catcher_util/catcher_config.dart';
import 'package:chaldea/components/components.dart';
import 'package:chaldea/modules/chaldea.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  // make sure flutter packages like path_provider is working now
  WidgetsFlutterBinding.ensureInitialized();
  // final sp = await SharedPreferences.getInstance();
  // final beta = sp.getBool('beta') == true;
  const beta = true;
  await db.paths.initRootPath();
  await AppInfo.resolve(db.paths.appPath);
  if (beta && AppInfo.isDebugDevice && kDebugMode) {
    if (kIsWeb) {
      setUrlStrategy(PathUrlStrategy());
    }
    await _mainNext();
  } else {
    await _mainLegacy();
  }
}

Future<void> _mainNext() async {
  runApp(ChaldeaNext());
}

Future<void> _mainLegacy() async {
  await db.initial().catchError((e, s) async {
    db.initErrorDetail =
        FlutterErrorDetails(exception: e, stack: s, library: 'initiation');
    logger.e('db.initial failed', e, s);
    Future.delayed(const Duration(seconds: 10), () {
      Catcher.reportCheckedError(e, s);
    });
  });

  final catcherOptions = CatcherUtility.getOptions();
  if (kDebugMode) {
    runApp(const Chaldea());
  } else {
    Catcher(
      rootWidget: const Chaldea(),
      debugConfig: catcherOptions,
      profileConfig: catcherOptions,
      releaseConfig: catcherOptions,
      navigatorKey: kAppKey,
      ensureInitialized: true,
      enableLogger: kDebugMode,
    );
  }
}
