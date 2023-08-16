import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'rive_mobile_method_channel.dart';

abstract class RiveMobilePlatform extends PlatformInterface {
  /// Constructs a RiveMobilePlatform.
  RiveMobilePlatform() : super(token: _token);

  static final Object _token = Object();

  static RiveMobilePlatform _instance = MethodChannelRiveMobile();

  /// The default instance of [RiveMobilePlatform] to use.
  ///
  /// Defaults to [MethodChannelRiveMobile].
  static RiveMobilePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RiveMobilePlatform] when
  /// they register themselves.
  static set instance(RiveMobilePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
