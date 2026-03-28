import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

import 'logger.dart';

/// Device information utility
class DeviceInfo {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static BaseDeviceInfo? _deviceInfo;

  /// Initialize device info (call this early in app lifecycle)
  static Future<void> initialize() async {
    try {
      if (Platform.isAndroid) {
        _deviceInfo = await _deviceInfoPlugin.androidInfo;
      } else if (Platform.isIOS) {
        _deviceInfo = await _deviceInfoPlugin.iosInfo;
      } else if (Platform.isWindows) {
        _deviceInfo = await _deviceInfoPlugin.windowsInfo;
      } else if (Platform.isMacOS) {
        _deviceInfo = await _deviceInfoPlugin.macOsInfo;
      } else if (Platform.isLinux) {
        _deviceInfo = await _deviceInfoPlugin.linuxInfo;
      }
    } catch (e) {
      AppLogger.e('Failed to get device info', e);
    }
  }

  /// Get device name
  static String get deviceName {
    if (_deviceInfo == null) return 'Unknown Device';

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return androidInfo.model;
    } else if (_deviceInfo is IosDeviceInfo) {
      final iosInfo = _deviceInfo as IosDeviceInfo;
      return iosInfo.name;
    } else if (_deviceInfo is WindowsDeviceInfo) {
      final windowsInfo = _deviceInfo as WindowsDeviceInfo;
      return windowsInfo.computerName;
    } else if (_deviceInfo is MacOsDeviceInfo) {
      final macInfo = _deviceInfo as MacOsDeviceInfo;
      return macInfo.computerName;
    } else if (_deviceInfo is LinuxDeviceInfo) {
      final linuxInfo = _deviceInfo as LinuxDeviceInfo;
      return linuxInfo.name;
    }

    return 'Unknown Device';
  }

  /// Get device model
  static String get deviceModel {
    if (_deviceInfo == null) return 'Unknown';

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return androidInfo.model;
    } else if (_deviceInfo is IosDeviceInfo) {
      final iosInfo = _deviceInfo as IosDeviceInfo;
      return iosInfo.model;
    }

    return 'Unknown';
  }

  /// Get device manufacturer
  static String get manufacturer {
    if (_deviceInfo == null) return 'Unknown';

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return androidInfo.manufacturer;
    } else if (_deviceInfo is IosDeviceInfo) {
      return 'Apple';
    }

    return 'Unknown';
  }

  /// Get OS version
  static String get osVersion {
    if (_deviceInfo == null) return 'Unknown';

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return 'Android ${androidInfo.version.release} (API ${androidInfo.version.sdkInt})';
    } else if (_deviceInfo is IosDeviceInfo) {
      final iosInfo = _deviceInfo as IosDeviceInfo;
      return 'iOS ${iosInfo.systemVersion}';
    } else if (_deviceInfo is WindowsDeviceInfo) {
      final windowsInfo = _deviceInfo as WindowsDeviceInfo;
      return 'Windows ${windowsInfo.productName} ${windowsInfo.displayVersion}';
    } else if (_deviceInfo is MacOsDeviceInfo) {
      final macInfo = _deviceInfo as MacOsDeviceInfo;
      return 'macOS ${macInfo.osRelease}';
    } else if (_deviceInfo is LinuxDeviceInfo) {
      final linuxInfo = _deviceInfo as LinuxDeviceInfo;
      return 'Linux ${linuxInfo.version}';
    }

    return 'Unknown';
  }

  /// Get device ID (unique identifier)
  static String get deviceId {
    if (_deviceInfo == null) return 'Unknown';

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return androidInfo.id;
    } else if (_deviceInfo is IosDeviceInfo) {
      final iosInfo = _deviceInfo as IosDeviceInfo;
      return iosInfo.identifierForVendor ?? 'Unknown';
    } else if (_deviceInfo is WindowsDeviceInfo) {
      final windowsInfo = _deviceInfo as WindowsDeviceInfo;
      return windowsInfo.deviceId;
    }

    return 'Unknown';
  }

  /// Check if device is physical (not emulator/simulator)
  static bool get isPhysicalDevice {
    if (_deviceInfo == null) return true;

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return androidInfo.isPhysicalDevice;
    } else if (_deviceInfo is IosDeviceInfo) {
      final iosInfo = _deviceInfo as IosDeviceInfo;
      return iosInfo.isPhysicalDevice;
    }

    return true; // Assume physical for other platforms
  }

  /// Check if device is rooted/jailbroken
  static bool get isRooted {
    if (_deviceInfo == null) return false;

    if (_deviceInfo is AndroidDeviceInfo) {
      final androidInfo = _deviceInfo as AndroidDeviceInfo;
      return androidInfo.isPhysicalDevice == false; // Emulator check as proxy
    }

    return false; // Not easily detectable on other platforms
  }

  /// Get screen resolution
  static String get screenResolution {
    // This would need to be passed from BuildContext or MediaQuery
    // For now, return placeholder
    return 'Unknown';
  }

  /// Get available memory (approximate)
  static String get memoryInfo {
    if (_deviceInfo == null) return 'Unknown';

    // Limited info available from device_info_plus
    // Would need additional packages for detailed memory info
    return 'Unknown';
  }

  /// Get storage info
  static String get storageInfo {
    // Would need additional packages for storage info
    return 'Unknown';
  }

  /// Get battery level (would need battery_plus package)
  static Future<int?> getBatteryLevel() async {
    // Would need battery_plus package
    return null;
  }

  /// Get network type (WiFi, Cellular, etc.)
  static String get networkType {
    // Would need connectivity_plus package
    return 'Unknown';
  }

  /// Get location permission status
  static Future<bool> get hasLocationPermission async {
    // Would need permission_handler package
    return false;
  }

  /// Get camera permission status
  static Future<bool> get hasCameraPermission async {
    // Would need permission_handler package
    return false;
  }

  /// Get all device info as map
  static Map<String, dynamic> getDeviceInfoMap() {
    return {
      'name': deviceName,
      'model': deviceModel,
      'manufacturer': manufacturer,
      'osVersion': osVersion,
      'deviceId': deviceId,
      'isPhysicalDevice': isPhysicalDevice,
      'isRooted': isRooted,
      'platform': Platform.operatingSystem,
      'platformVersion': Platform.operatingSystemVersion,
      'numberOfProcessors': Platform.numberOfProcessors,
      'locale': Platform.localeName,
    };
  }

  /// Get user agent string for web requests
  static String get userAgent {
    final platform = Platform.operatingSystem;
    final version = Platform.operatingSystemVersion;
    final appName = 'Nonstop'; // Should be from config
    final appVersion = '1.0.0'; // Should be from config

    return '$appName/$appVersion ($platform $version)';
  }

  /// Check if device supports feature
  static bool supportsFeature(String feature) {
    // Could be extended to check for specific hardware features
    switch (feature.toLowerCase()) {
      case 'camera':
        return true; // Assume all modern devices have camera
      case 'gps':
        return true; // Assume most devices have GPS
      case 'bluetooth':
        return true; // Assume most devices have Bluetooth
      case 'nfc':
        // Could check device capabilities
        return false;
      default:
        return false;
    }
  }

  /// Get app version (would need package_info_plus)
  static String get appVersion => '1.0.0'; // Placeholder

  /// Get build number (would need package_info_plus)
  static String get buildNumber => '1'; // Placeholder
}
