import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_virtual_keyboard_custom_layout_musma_method_channel.dart';

abstract class VirtualKeyboardCustomLayoutOnexPlatform
    extends PlatformInterface {
  /// Constructs a VirtualKeyboardCustomLayoutOnexPlatform.
  VirtualKeyboardCustomLayoutOnexPlatform() : super(token: _token);

  static final Object _token = Object();

  static VirtualKeyboardCustomLayoutOnexPlatform _instance =
      MethodChannelVirtualKeyboardCustomLayoutOnex();

  /// The default instance of [VirtualKeyboardCustomLayoutOnexPlatform] to use.
  ///
  /// Defaults to [MethodChannelVirtualKeyboardCustomLayoutOnex].
  static VirtualKeyboardCustomLayoutOnexPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [VirtualKeyboardCustomLayoutOnexPlatform] when
  /// they register themselves.
  static set instance(VirtualKeyboardCustomLayoutOnexPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
