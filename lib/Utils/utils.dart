import 'package:package_info_plus/package_info_plus.dart';

class Utils {
  Future<String> _getVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version.toString();
  }

}