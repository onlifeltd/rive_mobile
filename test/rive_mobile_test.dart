import 'package:flutter_test/flutter_test.dart';
import 'package:rive_mobile/rive_mobile.dart';
import 'package:rive_mobile/rive_mobile_platform_interface.dart';
import 'package:rive_mobile/rive_mobile_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockRiveMobilePlatform
    with MockPlatformInterfaceMixin
    implements RiveMobilePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final RiveMobilePlatform initialPlatform = RiveMobilePlatform.instance;

  test('$MethodChannelRiveMobile is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelRiveMobile>());
  });

  test('getPlatformVersion', () async {
    RiveMobile riveMobilePlugin = RiveMobile();
    MockRiveMobilePlatform fakePlatform = MockRiveMobilePlatform();
    RiveMobilePlatform.instance = fakePlatform;

    expect(await riveMobilePlugin.getPlatformVersion(), '42');
  });
}
