import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'rive_mobile_platform_interface.dart';

/// An implementation of [RiveMobilePlatform] that uses method channels.
class MethodChannelRiveMobile extends RiveMobilePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('rive_mobile');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
