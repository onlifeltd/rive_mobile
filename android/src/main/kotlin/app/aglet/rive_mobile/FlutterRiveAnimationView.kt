package app.aglet.rive_mobile

import android.content.Context
import android.util.Log
import android.view.View
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView
import app.rive.runtime.kotlin.RiveAnimationView
import io.flutter.view.FlutterMain.getLookupKeyForAsset
import app.rive.runtime.kotlin.core.File
import app.rive.runtime.kotlin.core.Fit


data class RiveAnimationOptions(val asset: String?, val fit: Int?) {
    companion object {
        fun from(params: Map<String, Any>): RiveAnimationOptions {
            return RiveAnimationOptions(
                params["asset"] as? String,
                params["fit"] as? Int
            )
        }
    }
}

class FlutterRiveAnimationView internal constructor(
    context: Context,
    initOptions: RiveAnimationOptions,
    messenger: BinaryMessenger,
    id: Int
) :
    PlatformView, MethodCallHandler {
    private val context: Context
    private val riveAnimationView: RiveAnimationView
    private val methodChannel: MethodChannel
    override fun getView(): View {
        return riveAnimationView
    }

    companion object {
        const val TAG = "FlutterRiveView"
    }

    init {
        Log.w(TAG, "init")
        this.context = context
        riveAnimationView = RiveAnimationView(context)

        methodChannel = MethodChannel(messenger, "app.aglet/flutter_rive_animation_view_$id")
        methodChannel.setMethodCallHandler(this)

        applyRiveAnimationOptions(initOptions)
    }

    private fun applyRiveAnimationOptions(initOptions: RiveAnimationOptions) {
        if (initOptions.asset != null) {
            setAccess(initOptions.asset)
        }
        if (initOptions.fit != null) {
            setFit(initOptions.fit)
        }
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "applyOptions" -> methodApplyOptions(methodCall, result)
            else -> result.notImplemented()
        }
    }

    private fun methodApplyOptions(methodCall: MethodCall, result: MethodChannel.Result) {
        applyRiveAnimationOptions(
            RiveAnimationOptions.from(
                methodCall.arguments as Map<String, Any>
            )
        )
        result.success(null)
    }

    private fun setAccess(asset: String) = context.assets.open(getLookupKeyForAsset(asset)).use {
        val file = File(it.readBytes())
        riveAnimationView.setRiveFile(file)
        file.release()
    }

    private fun setFit(index: Int) = try {
        riveAnimationView.fit = Fit.fromIndex(index)
    } catch (e: Exception) {
        Log.e(TAG, "setFit", e)
    }

    override fun dispose() {
    }
}