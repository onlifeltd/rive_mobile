import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'rive_mobile_platform_interface.dart';

class RiveMobile {
  Future<String?> getPlatformVersion() {
    return RiveMobilePlatform.instance.getPlatformVersion();
  }
}
