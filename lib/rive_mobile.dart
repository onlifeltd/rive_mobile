
import 'rive_mobile_platform_interface.dart';

class RiveMobile {
  Future<String?> getPlatformVersion() {
    return RiveMobilePlatform.instance.getPlatformVersion();
  }
}
