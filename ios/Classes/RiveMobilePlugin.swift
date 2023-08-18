import Flutter
import UIKit

public class RiveMobilePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(RiveAnimationViewFactory(messenger: registrar.messenger(), registrar: registrar), withId: "app.aglet/flutter_rive_animation_view")
  }
}
