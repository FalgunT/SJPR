import 'package:taxrun/common/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunctions {
  final AppThemeState _appTheme = AppThemeState();
  static CommonFunctions? _instance;

  static CommonFunctions? getInstance() {
    _instance ??= CommonFunctions();
    return _instance;
  }

  Future<void> launchInBrowser(String url) async {
    final Uri toLaunch = Uri.parse(url);
    /* final Uri toLaunch =
    Uri.https(url, path);*/
    if (!await launchUrl(
      toLaunch,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
