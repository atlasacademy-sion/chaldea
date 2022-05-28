import 'package:url_launcher/url_launcher.dart' as launcher;

import '../packages/language.dart';
import 'constants.dart';

class HttpUrlHelper {
  HttpUrlHelper._();
  static String projectDocUrl(String path, [bool? isZh]) {
    isZh ??= Language.isZH;
    return kProjectDocRoot +
        (isZh ? '/zh/' : '/') +
        (path.startsWith('/') ? path.substring(1) : path);
  }
}

Future<bool> launch(String url) {
  return launcher.launchUrl(Uri.parse(url));
}

Future<bool> canLaunch(String url) {
  return launcher.canLaunchUrl(Uri.parse(url));
}
