import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RiveAnimation extends StatefulWidget {
  final String? asset;
  final BoxFit? fit;

  const RiveAnimation.asset(this.asset, {this.fit, Key? key}) : super(key: key);

  get option => <String, dynamic>{
        'asset': asset,
        'fit': fit?.index,
      };

  @override
  State<RiveAnimation> createState() => _RiveAnimationState();
}

class _RiveAnimationState extends State<RiveAnimation> {
  RiveAnimationViewController? controller;

  @override
  void didUpdateWidget(covariant RiveAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.option != oldWidget.option) {
      controller?.applyOption(widget.option);
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'app.aglet/flutter_rive_animation_view',
          creationParams: widget.option,
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'app.aglet/flutter_rive_animation_view',
          creationParams: widget.option,
          creationParamsCodec: const StandardMessageCodec(),
          onPlatformViewCreated: _onPlatformViewCreated,
        );
      default:
        return Text('$defaultTargetPlatform is not yet supported');
    }
  }

  Future<void> _onPlatformViewCreated(int id) async {
    controller = RiveAnimationViewController._(id);
  }
}

class RiveAnimationViewController {
  RiveAnimationViewController._(int id)
      : _channel = MethodChannel('app.aglet/flutter_rive_animation_view_$id');

  final MethodChannel _channel;

  Future<void> applyOption(Map<String, dynamic> option) async {
    return _channel.invokeMethod('applyOption', option);
  }
}
