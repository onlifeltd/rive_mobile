import Foundation
import Flutter
import UIKit
import RiveRuntime

class FlutterRiveAnimationView: NSObject, FlutterPlatformView {
    private var _nativeRiveView: RiveView
    private var _riveViewModel: RiveViewModel?
    private var _methodChannel: FlutterMethodChannel
    private var _registrar: FlutterPluginRegistrar
    
    
    func view() -> UIView {
        return _nativeRiveView
    }
    
    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger,
        registrar: FlutterPluginRegistrar
    ) {
        _registrar = registrar
        _nativeRiveView = RiveView()
        _riveViewModel = FlutterRiveAnimationView.getRiveVm(arguments: args, registrar: registrar)
        _riveViewModel?.setView(_nativeRiveView)
        _nativeRiveView.frame = frame
        _methodChannel = FlutterMethodChannel(name: "app.aglet/flutter_rive_animation_view_\(viewId)", binaryMessenger: messenger)
        
        super.init()
        _methodChannel.setMethodCallHandler(onMethodCall)
    }
    
    
    func onMethodCall(call: FlutterMethodCall, result: FlutterResult) {
        switch(call.method){
        case "applyOptions":
            methodCallApplyOptions(call:call, result:result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func methodCallApplyOptions(call: FlutterMethodCall, result: FlutterResult){
        applyOptions(arguments: call.arguments)
        result(nil)
    }
    
    func applyOptions(arguments: Any?) {
        if let vm = FlutterRiveAnimationView.getRiveVm(arguments: arguments, registrar: _registrar) {
            _riveViewModel = vm
            _riveViewModel?.setView(_nativeRiveView)
        }
    }
    
    static func getRiveVm(arguments args: Any?, registrar: FlutterPluginRegistrar) -> RiveViewModel? {
        var vm: RiveViewModel?
        
        var asset: String?
        var fitValue: Int = 0
        
        if let args = args as? [String: Any] {
            asset = args ["asset"] as? String
            fitValue = args ["fit"] as? Int ?? 0
        }
        
        if let asset = asset {
            let key = registrar.lookupKey(forAsset: asset)
            if let fit = RiveFit(rawValue: fitValue) {
                vm = RiveViewModel(fileName: key, extension: "", fit: fit)
            } else {
                vm = RiveViewModel(fileName: key, extension: "")
            }
        }
        
        return vm
    }
}

