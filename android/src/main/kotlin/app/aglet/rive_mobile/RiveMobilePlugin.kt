package app.aglet.rive_mobile

import androidx.annotation.NonNull
import app.rive.runtime.kotlin.core.Rive

import io.flutter.embedding.engine.plugins.FlutterPlugin

class RiveMobilePlugin: FlutterPlugin {

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {

    binding.platformViewRegistry.registerViewFactory(
      "app.aglet/flutter_rive_animation_view", RiveAnimationViewFactory(binding.binaryMessenger)
    )

    Rive.init(binding.applicationContext)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}
