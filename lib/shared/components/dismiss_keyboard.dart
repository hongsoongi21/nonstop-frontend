import 'package:flutter/material.dart';

/// A widget that dismisses the keyboard when tapping outside of text fields.
///
/// This is especially important for iOS where the keyboard doesn't have a
/// dismiss button by default. Wrap your screen content with this widget to
/// enable tap-to-dismiss keyboard behavior.
///
/// Usage:
/// ```dart
/// DismissKeyboard(
///   child: YourScreenContent(),
/// )
/// ```
class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Dismiss keyboard by unfocusing any focused widget
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}

/// Extension on BuildContext for easy keyboard dismissal
extension KeyboardDismissExtension on BuildContext {
  /// Dismisses the keyboard if it's currently showing
  void dismissKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      currentFocus.unfocus();
    }
  }
}
